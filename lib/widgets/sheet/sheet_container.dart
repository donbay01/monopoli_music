import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:monopoli/models/audio/index.dart';
import 'package:monopoli/models/audio/track.dart';
import 'package:monopoli/providers/nav.dart';
import 'package:monopoli/providers/player.dart';
import '../../screens/player/music_playing.dart';
import 'minimized_player.dart';

class PlayerSheet extends ConsumerStatefulWidget {
  final Track track;
  final AudioApiResponse audio;
  final AudioPlayer player;

  const PlayerSheet({
    super.key,
    required this.track,
    required this.audio,
    required this.player,
  });

  @override
  ConsumerState<PlayerSheet> createState() => _PlayerSheetState();
}

class _PlayerSheetState extends ConsumerState<PlayerSheet>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _heightAnimation;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );
      _heightAnimation = Tween<double>(
        begin: 70.0,
        end: MediaQuery.of(context).size.height,
      ).animate(
        CurvedAnimation(
          parent: _controller!,
          curve: Curves.easeInOut,
        ),
      );

      setState(() {});
    });
    super.initState();
  }

  void toggleSheet() {
    ref.read(navShowing.notifier).state = !ref.read(navShowing);
    var isExpand = ref.read(isExpanded);
    if (isExpand) {
      _controller?.reverse();
    } else {
      _controller?.forward();
    }

    ref.read(isExpanded.notifier).state = !isExpand;
    // setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const SizedBox.shrink();
    }

    return Consumer(
      builder: (context, ref, _) {
        var isExpand = ref.watch(isExpanded);

        return GestureDetector(
          onTap: toggleSheet,
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta! > 0 && isExpand) {
              toggleSheet();
            } else if (details.primaryDelta! < 0 && !isExpand) {
              toggleSheet();
            }
          },
          child: AnimatedBuilder(
            animation: _controller!,
            builder: (context, child) {
              return Container(
                height: _heightAnimation!.value,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: isExpand
                    ? MusicPlayerPage(
                        audio: widget.audio,
                        track: widget.track,
                        function: () => toggleSheet(),
                      )
                    : MinimizedPlayer(
                        player: widget.player,
                        track: widget.track,
                      ),
              );
            },
          ),
        );
      },
    );
  }
}
