import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monopoli/services/spotify.dart';
import 'package:zap_sizer/zap_sizer.dart';

import '../../theme/colors.dart';
import '../../theme/text_style.dart';
import '../albums/details.dart';
import '../albums/index.dart';

class Albums extends StatelessWidget {
  final String token;
  final List<String> ids;

  const Albums({
    super.key,
    required this.token,
    required this.ids,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Spotify.getMultipleAlbums(token, ids),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Image(image: AssetImage('assets/internet.png')),
                Text(
                  'Check internet Connection',style: mediumText(primaryWhite),
                ),
              ],
            ),
          );
        }

        var snap = snapshot.data!;

        return GridView.builder(
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 25,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: snap.length,
          itemBuilder: (context, index) {
            final album = snap[index];

            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongListScreen(
                    album: album,
                    token: token,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: album.images.first.url,
                      fit: BoxFit.cover,
                      width: 40.w,
                      height: 40.w,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    album.name,
                    style: mediumBold(primaryWhite),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
