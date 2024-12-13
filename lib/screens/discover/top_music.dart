import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monopoli/models/audio/track.dart';
import 'package:monopoli/providers/player.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/services/music.dart';
import 'package:monopoli/services/spotify.dart';
import 'package:zap_sizer/zap_sizer.dart';
import '../../helper/options_sheet.dart';
import '../../services/user.dart';
import '../../theme/colors.dart';
import '../../theme/text_style.dart';
import 'package:loader_overlay/loader_overlay.dart';

class TopMusic extends ConsumerWidget {
  final String token;

  const TopMusic({
    super.key,
    required this.token,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    var trackIds = [
      '2qdwZPTNCHb8DXfQin53WK',
      '2kaH2Z8ezDUKf6fNw250rZ',
      '1mk8ZC9OeTZMr8Wy31LqRj',
      '6XBIOtdSL47qn201KKNCA0',
      '1qxKva4IzWde7m2jLpZvDU',
      '2nYeyMeqYDiFSYYtl2BWD6'
    ];
    var size = MediaQuery.of(context).size;
    var user = AuthService.getUser();

    return SingleChildScrollView(
      child: Container(
        height: size.height * 0.5,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/topMusic.png'),fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Music',
                    style: mediumSemiBold(primaryWhite),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: primaryWhite, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5),
                        child: Text(
                          'View all',
                          style: smallBold(primaryWhite),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: Spotify.getMultipleTracks(token, trackIds),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        children: [
                          Image(image: AssetImage('assets/internet.png')),
                          Text(
                            'Check internet Connection',
                            style: mediumText(primaryWhite),
                          ),
                        ],
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
                                    UserService.addSong(
                                      user!.uid,
                                      song,
                                      a,
                                    );

                                    ref.read(controller)?.forward();
                                    ref.read(isExpanded.notifier).state = true;
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
                                            width: 35.w,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  song.name ?? 'N/A',
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: smallBold(
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
                                      IconButton(
                                        onPressed: () => showSongDetails(
                                          context,
                                          ref,
                                          song,
                                          null,
                                        ),
                                        icon: Icon(
                                          FontAwesomeIcons.ellipsisVertical,
                                          color: grey,
                                        ),
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

  void _showSongDetails(
    BuildContext context,
    Track song,
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.grey[900],
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        return Container(
          height: height * 0.6,
          width: width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              imageUrl: song.album!.cover!.first.url,
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                song.name!,
                                style: mediumBold(primaryWhite),
                              ),
                              Text(
                                song.artists!.first!.name!,
                                style: smallText(grey),
                              )
                            ],
                          )
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.clear,
                          color: primaryWhite,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: grey,
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.playlist_add,
                          color: primaryWhite,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Add to playlist',
                          style: mediumBold(primaryWhite),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.remove,
                          color: primaryWhite,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Remove from library',
                          style: mediumBold(primaryWhite),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.download_for_offline_outlined,
                          color: primaryWhite,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Download',
                          style: mediumBold(primaryWhite),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.ios_share,
                          color: primaryWhite,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Share',
                          style: mediumBold(primaryWhite),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
