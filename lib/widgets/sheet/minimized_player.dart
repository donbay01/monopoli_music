import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:zap_sizer/zap_sizer.dart';
import '../../models/audio/track.dart';

class MinimizedPlayer extends StatelessWidget {
  final AudioPlayer player;
  final Track track;

  const MinimizedPlayer({
    super.key,
    required this.player,
    required this.track,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const SizedBox.shrink();
        }

        var data = snapshot.data;
        var isPlaying = data?.playing ?? false;

        return Container(
          color: Colors.grey[900],
          padding: EdgeInsets.symmetric(
            horizontal: 6.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Hero(
                      tag: Key(track.id!),
                      child: CachedNetworkImage(
                        imageUrl: track.album!.cover?.first.url ??
                            track.album!.images!.first.url,
                        fit: BoxFit.cover,
                        height: 5.5.h,
                        width: 5.5.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  SizedBox(
                    width: 43.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          track.name!,
                          overflow: TextOverflow.ellipsis,
                          style: mediumSemiBold(Colors.white),
                        ),
                        Text(
                          track.artists!.first.name ?? 'N/A',
                          style: mediumText(Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isPlaying
                          ? FontAwesomeIcons.pause
                          : FontAwesomeIcons.play,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: () {
                      if (isPlaying) {
                        player.pause();
                      } else {
                        player.play();
                      }
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.forward,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
