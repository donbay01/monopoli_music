import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monopoli/screens/dashboard/discover/featured_songs.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:monopoli/widgets/user/avatar.dart';
import 'package:zap_sizer/zap_sizer.dart';

import '../../player/music_playing.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class Song {
  final String title;
  final String artist;
  final String duration;
  final String imagePath;

  Song(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.imagePath});
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
    title: 'Wave',
    artist: 'Asake',
    duration: '2:58',
    imagePath: 'assets/asake.png',
  ),
  Song(
    title: 'Higher',
    artist: 'Burna',
    duration: '3:45',
    imagePath: 'assets/city.png',
  ),
  Song(
    title: 'Wildest dream',
    artist: '21 Savage',
    duration: '4:12',
    imagePath: 'assets/savage.png',
  ),
  Song(
    title: 'Juju',
    artist: 'Asake',
    duration: '2:58',
    imagePath: 'assets/album1.png',
  ),
  Song(
    title: 'Higher',
    artist: 'Burna',
    duration: '3:45',
    imagePath: 'assets/album2.png',
  ),
  Song(
    title: 'Feel',
    artist: 'Davido',
    duration: '4:12',
    imagePath: 'assets/album3.png',
  ),
];

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldBlack,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover',
                    style: boldText(primaryWhite),
                  ),
                  const UserAvatar(),
                ],
              ),
              // const FeaturedSongs(),
              SizedBox(
                height: 40,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      height: height * 0.5,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF58556E), Color(0xff66656D)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SingleChildScrollView(
                          // scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Top Music',
                                    style: largeText(primaryWhite),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'view all',
                                        style: mediumBold(primaryWhite),
                                      ))
                                ],
                              ),
                              Container(
                                height: height * 0.4,
                                width: width,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: songs.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final song = songs[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          MusicPlayerPage(
                                                            imagePath:
                                                                song.imagePath,
                                                            musicTitle:
                                                                song.title,
                                                            artistName:
                                                                song.artist,
                                                          )));
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          song.imagePath,
                                                          height: 50,
                                                          width: 50,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            song.title,
                                                            style: mediumBold(
                                                                primaryWhite),
                                                          ),
                                                          Text(
                                                            song.artist,
                                                            style:
                                                                smallText(grey),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        // _showSongDetails(context, song);
                                                      },
                                                      icon: Icon(
                                                        FontAwesomeIcons
                                                            .ellipsisVertical,
                                                        color: primaryWhite,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: height * 0.5,
                      width: width * 0.75,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF475B47), Color(0xff494F51)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Made For You',
                                    style: largeText(primaryWhite),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'view all',
                                        style: mediumBold(primaryWhite),
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: height * 0.4,
                                width: width,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: songs.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final song = songs[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          MusicPlayerPage(
                                                            imagePath:
                                                                'assets/burnaplay.png',
                                                            musicTitle:
                                                                'Higher',
                                                            artistName:
                                                                'Burna Boy',
                                                          )));
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          song.imagePath,
                                                          height: 50,
                                                          width: 50,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            song.title,
                                                            style: mediumBold(
                                                                primaryWhite),
                                                          ),
                                                          Text(
                                                            song.artist,
                                                            style:
                                                                smallText(grey),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        // _showSongDetails(context, song);
                                                      },
                                                      icon: Icon(
                                                        FontAwesomeIcons
                                                            .ellipsisVertical,
                                                        color: primaryWhite,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Trending Album',
                style: mediumSemiBold(primaryWhite),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MusicPlayerPage(
                                      imagePath: 'assets/album1.png',
                                      musicTitle: 'Wave',
                                      artistName: 'Asake',
                                    )));
                      },
                      child: Container(
                        height: height * 0.2,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image(
                          image: AssetImage('assets/album1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MusicPlayerPage(
                                      imagePath: 'assets/album2.png',
                                      musicTitle: 'Wave',
                                      artistName: 'Asake',
                                    )));
                      },
                      child: Container(
                        height: height * 0.2,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image(
                          image: AssetImage('assets/album2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MusicPlayerPage(
                                      imagePath: 'assets/album3.png',
                                      musicTitle: 'Wave',
                                      artistName: 'Asake',
                                    )));
                      },
                      child: Container(
                        height: height * 0.2,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image(
                          image: AssetImage('assets/album3.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
