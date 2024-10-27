import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/widgets/user/avatar.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:zap_sizer/zap_sizer.dart';

import '../../../theme/text_style.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}
class Song {
  final String title;
  final String artist;
  final String duration;
  final String imagePath;

  Song({required this.title, required this.artist, required this.duration, required this.imagePath});
}

final List<Song> songs = [
  Song(
    title: 'Higher',
    artist: 'Burna',
    duration: '3:45',
    imagePath: 'assets/burna.png',
  ),
  Song(
    title: 'Feel',
    artist: 'Davido',
    duration: '4:12',
    imagePath: 'assets/davido.png',
  ),
  Song(
    title: 'Juju',
    artist: 'Asake',
    duration: '2:58',
    imagePath: 'assets/asake.png',
  ),
];

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    String selectedText = 'Playlist';
    var tags = [ 'Playlist','Liked Songs ', 'Downloaded', 'Shared'];
    return  Scaffold(
      backgroundColor: scaffoldBlack,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Library',style: largeText(primaryWhite),),
                Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.add,color: primaryWhite,)),
                    SizedBox(width: 10,),
                    UserAvatar()
                  ],
                )
              ],
            ),
            SizedBox(
              width: 95.w,
              height: 10.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: tags.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedText = tags[index];
                      });
                    },
                    child: Chip(
                      backgroundColor: primaryBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        tags[index],
                        style: mediumBold(primaryWhite),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  width: 3.w,
                ),
              ),
            ),
            GradientText(
              selectedText,
              style: TextStyle(
                fontSize: 25.0,
              ),
              colors: [
                purple,
                primaryWhite
              ],
            ),
            GradientText(
              selectedText,
              style: TextStyle(
                fontSize: 25.0,
              ),
              colors: [
                purple,
                primaryWhite
              ],
            ),GradientText(
              selectedText,
              style: TextStyle(
                fontSize: 25.0,
              ),
              colors: [
                purple,
                primaryWhite
              ],
            ),
            ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          song.imagePath,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        song.title,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        song.artist,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text(
                        song.duration,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
