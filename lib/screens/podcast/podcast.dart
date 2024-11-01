import 'package:flutter/material.dart';
import 'package:monopoli/screens/podcast/mini_player.dart';
import 'package:monopoli/screens/podcast/podcast_description.dart';
import 'package:monopoli/screens/podcast/podcast_header.dart';
import 'package:monopoli/theme/colors.dart';

import '../../theme/text_style.dart';
import 'episode_list.dart';

class PodcastPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBlack,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Podcast',
                  style: largeText(primaryWhite),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            PodcastHeader(),
            SizedBox(height: 16.0),
            PodcastDescription(),
            SizedBox(height: 16.0),
            EpisodesList(),
          ],
        ),
      ),
      // bottomNavigationBar: MiniPlayer(),
    );
  }
}
