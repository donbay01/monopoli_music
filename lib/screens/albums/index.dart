import 'package:flutter/material.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import '../../models/album_model.dart';
import '../player/music_playing.dart';

class AlbumListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: GridView.builder(
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
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SongListScreen(album: album),
              ),
            ),
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


class SongListScreen extends StatelessWidget {
  final Album album;

  SongListScreen({required this.album});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldBlack,
      appBar: AppBar(leading:IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios_new_outlined,color: primaryWhite,)) ,title: Text(album.title,style: mediumSemiBold(primaryWhite),),backgroundColor: Colors.transparent,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:20.0,right:20,top: 20),
                child: Image.asset(
                  album.imageAssetPath,
                  width: width * 5,
                  height: height * 0.35,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: album.songs.map((song) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  MusicPlayerPage(
                                    imagePath:
                                    song.imageUrl,
                                    musicTitle:
                                    song.title,
                                    artistName:
                                    song.artist,
                                  )));
                    },
                    child: ListTile(
                      leading: Image.asset(
                        song.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(song.title,style: mediumBold(primaryWhite),),
                      subtitle: Text(song.artist,style: mediumText(grey),),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 200,),
            ],
          ),
        ),
      ),
    );
  }
}
