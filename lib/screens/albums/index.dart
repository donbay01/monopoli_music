import 'package:flutter/material.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import '../../models/album_model.dart';
import '../player/music_playing.dart';
import 'details.dart';

class AlbumListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(10),
        physics: ClampingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 25,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: albums.length,
        itemBuilder: (context, index) {
          final album = albums[index];
          return GestureDetector(
            // onTap: () => Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => SongListScreen(album: album),
            //   ),
            // ),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    album.imageAssetPath,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  album.title,
                  style: mediumBold(primaryWhite),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
