import 'package:flutter/material.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';

class PodcastDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Learn from the best artists in the game, this podcast provides you with the latest music and trends',
      style: mediumText(primaryWhite),
    );
  }
}
