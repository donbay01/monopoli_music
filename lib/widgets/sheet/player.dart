import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:monopoli/providers/player.dart';
import 'sheet_container.dart';

class MusicPlayerSheet extends ConsumerStatefulWidget {
  const MusicPlayerSheet({super.key});

  @override
  _MusicPlayerSheetState createState() => _MusicPlayerSheetState();
}

class _MusicPlayerSheetState extends ConsumerState<MusicPlayerSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        var p = ref.watch(player);
        var track = ref.watch(trackProvider);
        var audio = ref.watch(audioProvider);

        if (track == null) {
          return const SizedBox.shrink();
        }

        p.setAudioSource(
          AudioSource.uri(
            Uri.parse(
              audio!.youtubeVideo.audio.first.url,
            ),
            tag: MediaItem(
              id: track.id!,
              album: track.album!.name,
              title: track.name!,
              displayTitle: track.name,
              artist: track.artists!.first.name,
              artUri: track.album!.cover == null
                  ? null
                  : Uri.parse(
                      track.album!.cover!.last.url,
                    ),
              genre: track.type,
            ),
          ),
        );

        return Align(
          alignment: Alignment.bottomCenter,
          child: PlayerSheet(
            audio: audio,
            player: p,
            track: track,
          ),
        );
      },
    );
  }
}
