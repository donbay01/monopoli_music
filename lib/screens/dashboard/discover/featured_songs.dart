import 'package:flutter/material.dart';
import 'package:monopoli/screens/dashboard/discover/playlist/index.dart';
import 'package:monopoli/services/music.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:zap_sizer/zap_sizer.dart';

class FeaturedSongs extends StatelessWidget {
  const FeaturedSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: FutureBuilder(
        future: MusicService.getTodaysHome(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Text(
              'An error occurred',
            );
          }

          var data = snapshot.data!;

          return GridView.builder(
            shrinkWrap: true,
            itemCount: data.contents.totalCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              var a = data.contents.items[index];

              return GestureDetector(
                onTap: () => pushScreenWithNavBar(
                  context,
                  PlaylistScreen(playlist: a),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      a.images.first.first.url,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
