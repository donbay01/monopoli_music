import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monopoli/models/spotify/album.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/services/music.dart';
import 'package:monopoli/services/spotify.dart';
import '../../providers/player.dart';
import '../../services/user.dart';
import '../../theme/colors.dart';
import '../../theme/text_style.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SongListScreen extends ConsumerStatefulWidget {
  final String id;
  final String name;
  final String image;

  final String token;

  const SongListScreen({
    super.key,
    required this.token,
    required this.id,
    required this.image,
    required this.name,
  });

  @override
  ConsumerState<SongListScreen> createState() => _SongListScreenState();
}

class _SongListScreenState extends ConsumerState<SongListScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = AuthService.getUser();

    return Scaffold(
      backgroundColor: scaffoldBlack,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: primaryWhite,
          ),
        ),
        title: Text(
          widget.name,
          style: mediumSemiBold(primaryWhite),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  width: size.width * 0.7,
                  height: size.height * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                future: Spotify.getAlbumTracks(
                  widget.token,
                  widget.id,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Text(
                      snapshot.error.toString(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    );
                  }

                  var data = snapshot.data!;

                  return Column(
                    children: data.map((track) {
                      return GestureDetector(
                        onTap: () async {
                          try {
                            context.loaderOverlay.show();
                            var t = await Spotify.getSingleTrack(
                              widget.token,
                              track['id'],
                            );
                            var audio = await MusicService.getTrackURL(
                              track['id'],
                            );
                            context.loaderOverlay.hide();

                            if (audio == null) {
                              return null;
                            }

                            ref.read(audioProvider.notifier).state = audio;
                            ref.read(trackProvider.notifier).state = t;
                            UserService.addSong(
                              user!.uid,
                              t,
                              audio,
                            );

                            ref.read(controller)?.forward();
                            ref.read(isExpanded.notifier).state = true;
                          } catch (e) {
                            print(e);
                            context.loaderOverlay.hide();
                            Fluttertoast.showToast(
                              msg: 'An error occurred. Try again later',
                            );
                          }
                        },
                        child: ListTile(
                          // leading: ClipRRect(
                          //   borderRadius: BorderRadius.circular(8),
                          //   child: CachedNetworkImage(
                          //     imageUrl: widget.album!.images!.first.url,
                          //     width: 60,
                          //     height: 60,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          title: Text(
                            track['name'],
                            style: smallBold(primaryWhite),
                          ),
                          subtitle: Text(
                            track['artists'][0]['name'],
                            style: smallText(grey),
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.ellipsisVertical,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
