import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monopoli/models/home/top_content.dart';
import 'package:monopoli/providers/player.dart';
import 'package:monopoli/providers/spotify.dart';
import 'package:monopoli/screens/player/index.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/services/music.dart';
import 'package:monopoli/services/spotify.dart';
import 'package:monopoli/services/user.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:loader_overlay/loader_overlay.dart';

class PlaylistScreen extends ConsumerWidget {
  final String playlistId;
  final String name;

  const PlaylistScreen({
    super.key,
    required this.playlistId,
    required this.name,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Scaffold(
      backgroundColor: scaffoldBlack,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: primaryWhite,
          ),
        ),
        title: Text(
          name,
          style: mediumText(primaryWhite),
        ),
        backgroundColor: scaffoldBlack,
      ),
      body: FutureBuilder(
        future: MusicService.getPlayList(playlistId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return const Text('error');
          }

          var data = snapshot.data!;

          return ListView.separated(
            itemBuilder: (context, index) {
              var a = data.content!.items![index];

              return ListTile(
                onTap: () async {
                  try {
                    context.loaderOverlay.show();
                    var token = ref.read(spotifyToken);
                    var track = await Spotify.getSingleTrack(token!, a.id!);
                    var audio = await MusicService.getTrackURL(a.shareUrl!);
                    context.loaderOverlay.hide();

                    ref.read(trackProvider.notifier).state = track;
                    ref.read(audioProvider.notifier).state = audio;

                    var user = AuthService.getUser();
                    UserService.addSong(
                      user!.uid,
                      track,
                      audio,
                    );
                  } catch (e) {
                    Fluttertoast.showToast(
                      msg: "An error occurred",
                    );
                  }
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: a.album!.cover.first.url,
                    width: 50,
                    height: 50,
                  ),
                ),
                title: Text(
                  a.name ?? 'N/A',
                  style: mediumText(primaryWhite),
                ),
                subtitle: Text(
                  a.artists?.first.name ?? 'N/A',
                  style: mediumText(primaryWhite),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 1.2.w,
            ),
            itemCount: data.content!.totalCount!,
          );
        },
      ),
    );
  }
}
