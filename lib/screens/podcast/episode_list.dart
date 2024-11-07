import 'package:flutter/material.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';

class EpisodesList extends StatelessWidget {
  final List<Map<String, String>> episodes = [
    {'title': 'Episode 1 - Introduction', 'duration': '20 min'},
    {'title': 'Episode 2 - Deep Dive', 'duration': '45 min'},
    // Add more episodes as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: episodes.length,
      itemBuilder: (context, index) {
        return EpisodeCard(
          title: episodes[index]['title']!,
          duration: episodes[index]['duration']!,
        );
      },
    );
  }
}

class EpisodeCard extends StatelessWidget {
  final String title;
  final String duration;

  EpisodeCard({required this.title, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: purple,
      child: ListTile(
        title: Text(title, style: mediumBold(primaryWhite)),
        subtitle: Text(duration,style: mediumText(primaryBlack),),
        trailing: IconButton(
          icon: Icon(Icons.play_circle_fill, color: primaryBlack),
          onPressed: () {
            // Handle play button press
          },
        ),
      ),
    );
  }
}
