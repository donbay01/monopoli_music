import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monopoli/monopoli.dart';
import 'package:monopoli/providers/spotify.dart';
import 'package:monopoli/screens/library/playlist_detail.dart';
import 'package:monopoli/screens/playlists/index.dart';
import 'package:monopoli/services/music.dart';
import 'package:monopoli/services/spotify.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:zap_sizer/zap_sizer.dart';

class GenreGridPage extends ConsumerWidget {
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    var token = ref.read(spotifyToken);

    if (token == null) {
      return const SizedBox.shrink();
    }

    return FutureBuilder(
      future: Spotify.getCategories(token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Text('Could not fetch categories');
        }

        var data = snapshot.data!;

        return SizedBox(
          height: 100.h,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              var c = data[index];

              return GestureDetector(
                onTap: () async {
                  var p = await Spotify.getCategoriesPlaylist(
                    token,
                    c.id,
                  );

                  pushScreenWithNavBar(
                    context,
                    CategoryPlaylist(
                      category: c,
                      playlists: p,
                    ),
                  );
                },
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: c.icons.first.url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      // SizedBox(height: 8),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: Text(
                            c.name,
                            style: mediumSemiBold(primaryWhite),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
