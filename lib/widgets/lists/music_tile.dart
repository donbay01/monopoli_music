import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:monopoli/models/audio/index.dart';
import 'package:monopoli/models/audio/track.dart';
import 'package:monopoli/services/user.dart';
import 'package:monopoli/widgets/lists/create_playlist.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zap_sizer/zap_sizer.dart';

import '../../providers/player.dart';
import '../../theme/colors.dart';
import '../../theme/text_style.dart';

class MusicTile extends ConsumerWidget {
  final Track track;
  final AudioApiResponse audio;
  final String userId;
  final bool isShared;
  final bool isDownloaded;
  final bool isPlaylist;

  const MusicTile({
    super.key,
    required this.audio,
    required this.track,
    required this.userId,
    this.isDownloaded = false,
    this.isPlaylist = false,
    this.isShared = false,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              ref.read(audioProvider.notifier).state = audio;
              ref.read(trackProvider.notifier).state = track;
              // ref.read(isExpanded.notifier).state = true;
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => MusicPlayerPage(
              //       imagePath: 'assets/burnaplay.png',
              //       musicTitle: 'Higher',
              //       artistName: 'Burna Boy',
              //     ),
              //   ),
              // );
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl: track.album?.cover?.first.url ??
                              track.album!.images!.first.url,
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 56.5.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              track.name ?? 'N/A',
                              style: mediumBold(primaryWhite),
                            ),
                            Text(
                              track.artists?.first.name ?? 'N/A',
                              style: smallText(grey),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () => showSongDetails(
                      context,
                      ref,
                      track,
                      audio,
                    ),
                    icon: const Icon(
                      FontAwesomeIcons.ellipsis,
                      color: Color.fromARGB(255, 116, 90, 90),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showSongDetails(
    BuildContext context,
    WidgetRef ref,
    Track track,
    AudioApiResponse audio,
  ) {
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
                                  track.album!.images!.first.url,
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 56.w,
                            child: Column(
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
                            ),
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
                  if (!isPlaylist) ...[
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.grey[900],
                          useRootNavigator: true,
                          builder: (_) => CreatePlaylist(
                            track: track,
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.playlist_add,
                            color: primaryWhite,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Add to playlist',
                            style: mediumBold(primaryWhite),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  GestureDetector(
                    onTap: () {
                      UserService.unLikeSong(userId, track.id!);
                      UserService.removeSong(userId, track);
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.remove,
                          color: primaryWhite,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Remove from library',
                          style: mediumBold(primaryWhite),
                        )
                      ],
                    ),
                  ),
                  if (!isDownloaded) ...[
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        var p = ref.read(player);
                        final audioSource = AudioSource.uri(
                          Uri.parse(
                            audio.downloadLink!,
                            // audio.youtubeVideo.audio.first.url,
                          ),
                          tag: MediaItem(
                            id: track.id!,
                            album: track.album!.name,
                            title: track.name!,
                            artUri: Uri.parse(track.album!.cover!.first.url),
                          ),
                        );
                        // final audioSource = LockCachingAudioSource(
                        //   Uri.parse(
                        //     audio.youtubeVideo.audio.first.url,
                        //   ),
                        // );
                        p.setAudioSource(audioSource);
                        UserService.updateSong(userId, track.id!, {
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
                  ],
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Share.shareUri(
                        Uri.parse(
                          audio.downloadLink!,
                          // audio.youtubeVideo.audio.first.url,
                        ),
                      );
                      UserService.updateSong(userId, track.id!, {
                        'shared': true,
                      });
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
}
