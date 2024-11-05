import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final SpotifyAlbum album;
  final String token;

  const SongListScreen({
    super.key,
    required this.album,
    required this.token,
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
          widget.album.name,
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
                  imageUrl: widget.album!.images!.first.url,
                  width: size.width * 5,
                  height: size.height * 0.35,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: Spotify.getAlbumTracks(widget.token, widget.album.id),
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
                            ref.read(audioProvider.notifier).state = audio;
                            ref.read(trackProvider.notifier).state = t;
                            UserService.addSong(
                              user!.uid,
                              t,
                              audio,
                            );
                            context.loaderOverlay.hide();
                          } catch (e) {
                            print(e);
                            context.loaderOverlay.hide();
                            Fluttertoast.showToast(
                              msg: 'An error occurred. Try again later',
                            );
                          }
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) => MusicPlayerPage(
                          //               imagePath: song.imageUrl,
                          //               musicTitle: song.title,
                          //               artistName: song.artist,
                          //             )));
                        },
                        child: ListTile(
                          // leading: CachedNetworkImage(
                          //   imageUrl: track.name,
                          //   width: 50,
                          //   height: 50,
                          //   fit: BoxFit.cover,
                          // ),
                          title: Text(
                            track['name'],
                            style: mediumBold(primaryWhite),
                          ),
                          subtitle: Text(
                            track['artists'][0]['name'],
                            style: mediumText(grey),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              SizedBox(
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
