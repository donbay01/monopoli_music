import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monopoli/models/spotify/category.dart';
import 'package:monopoli/screens/discover/playlist/index.dart';
import 'package:monopoli/screens/library/playlist_detail.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:zap_sizer/zap_sizer.dart';
import '../../models/spotify/playlist.dart';
import '../../theme/colors.dart';

class CategoryPlaylist extends StatelessWidget {
  final SpotifyCategory category;
  final List<SpotifyPlaylist> playlists;

  const CategoryPlaylist({
    super.key,
    required this.category,
    required this.playlists,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBlack,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        title: Text(
          category.name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 1.6.h,
        ),
        shrinkWrap: true,
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          var playlist = playlists[index];

          return GestureDetector(
            onTap: () => pushScreenWithNavBar(
              context,
              PlaylistScreen(
                name: playlist.name,
                playlistId: playlist.id,
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: playlist.images.first.url,
                    width: 15.w,
                    height: 15.w,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                SizedBox(
                  width: 64.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        playlist.name,
                        style: mediumBold(Colors.white),
                      ),
                      Text(
                        playlist.description,
                        maxLines: 3,
                        style: smallText(
                          Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
