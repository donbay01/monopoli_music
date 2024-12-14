import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:monopoli/models/audio/track.dart';
import 'package:monopoli/services/auth.dart';
import 'package:share_plus/share_plus.dart';

import '../models/audio/index.dart';
import '../providers/player.dart';
import '../services/user.dart';
import '../theme/colors.dart';
import '../theme/text_style.dart';

void showSongDetails(
  BuildContext context,
  WidgetRef ref,
  Track track,
  AudioApiResponse? audio,
) {
  var user = AuthService.getUser();

  showModalBottomSheet(
    backgroundColor: Colors.grey[900],
    context: context,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    builder: (context) {
      var size = MediaQuery.of(context).size;
      var height = size.height;
      var width = size.width;

      return SizedBox(
        height: height * 0.6,
        width: width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
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
                            imageUrl: track.album?.cover?.last.url ??
                                track.album!.images!.last.url!,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              track?.name ?? 'N/A',
                              style: mediumBold(primaryWhite),
                            ),
                            Text(
                              track.artists?.first.name ?? 'N/A',
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
                      icon: const Icon(
                        Icons.clear,
                        color: primaryWhite,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: grey,
                  height: 50,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    var p = ref.read(player);
                    final audioSource = AudioSource.uri(
                      Uri.parse(
                        audio!.downloadLink!,
                        // audio!.youtubeVideo.audio.first.url,
                      ),
                      tag: MediaItem(
                        id: track.id!,
                        album: track.album!.name,
                        title: track.name!,
                        artUri: Uri.parse(track.album!.cover!.first.url),
                      ),
                    );

                    p.setAudioSource(audioSource);
                    UserService.updateSong(user!.uid, track.id!, {
                      'downloaded': true,
                    });
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.download_for_offline_outlined,
                        color: primaryWhite,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Download',
                        style: mediumBold(primaryWhite),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    await Share.shareUri(
                      Uri.parse(
                        audio!.downloadLink!,
                        // audio!.youtubeVideo.audio.first.url,
                      ),
                    );
                    UserService.updateSong(user!.uid, track.id!, {
                      'shared': true,
                    });
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.ios_share,
                        color: primaryWhite,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Share',
                        style: mediumBold(primaryWhite),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
