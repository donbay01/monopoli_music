import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:monopoli/models/audio/index.dart';
import 'package:monopoli/models/audio/track.dart';
import '../../screens/player/music_playing.dart';
import 'minimized_player.dart';

class PlayerSheet extends StatefulWidget {
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
  State<PlayerSheet> createState() => _PlayerSheetState();
}

class _PlayerSheetState extends State<PlayerSheet>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;

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
        end: MediaQuery.of(context).size.height * 0.9,
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
    setState(() {
      if (isExpanded) {
        _controller?.reverse();
      } else {
        _controller?.forward();
      }
      isExpanded = !isExpanded;
    });
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

    return GestureDetector(
      onTap: toggleSheet,
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! > 0 && isExpanded) {
          toggleSheet();
        } else if (details.primaryDelta! < 0 && !isExpanded) {
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
            child: isExpanded
                ? MusicPlayerPage(
                    audio: widget.audio,
                    track: widget.track,
                  )
                : MinimizedPlayer(
                    player: widget.player,
                    track: widget.track,
                  ),
          );
        },
      ),
    );
  }
}
