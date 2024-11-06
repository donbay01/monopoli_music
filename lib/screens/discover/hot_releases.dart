import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monopoli/models/playlist/index.dart';
import 'package:monopoli/providers/player.dart';
import 'package:monopoli/services/music.dart';
import 'package:monopoli/services/spotify.dart';
import 'package:zap_sizer/zap_sizer.dart';
import '../../theme/colors.dart';
import '../../theme/text_style.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HotReleases extends ConsumerWidget {
  final String token;

  const HotReleases({
    super.key,
    required this.token,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    var trackIds = [
      '1mk8ZC9OeTZMr8Wy31LqRj',
      '6XBIOtdSL47qn201KKNCA0',
      '1qxKva4IzWde7m2jLpZvDU',
      '2nYeyMeqYDiFSYYtl2BWD6'
    ];
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.5,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        // gradient: const LinearGradient(
        //   colors: [
        //     Color(0xFF58556E),
        //     Color(0xff66656D),
        //   ],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FutureBuilder(
                future: Spotify.getMultipleTracks(token, trackIds),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'An error occurred',
                      ),
                    );
                  }

                  var data = snapshot.data;

                  return Container(
                    height: size.height * 0.4,
                    width: size.width,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: data?.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final song = data![index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    context.loaderOverlay.show();
                                    var a = await MusicService.getTrackURL(
                                      song.id!,
                                    );
                                    context.loaderOverlay.hide();

                                    ref.read(trackProvider.notifier).state =
                                        song;
                                    ref.read(audioProvider.notifier).state = a;
                                  } catch (e) {
                                    Fluttertoast.showToast(
                                      msg: 'An error occurred',
                                    );
                                  }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: CachedNetworkImage(
                                              imageUrl: song.album?.cover?.first
                                                      .url ??
                                                  song.album!.images!.first.url,
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: 43.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  song.name ?? 'N/A',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: mediumBold(
                                                    primaryWhite,
                                                  ),
                                                ),
                                                Text(
                                                  song.artists?.first.name ??
                                                      'N/A',
                                                  style: smallText(grey),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
