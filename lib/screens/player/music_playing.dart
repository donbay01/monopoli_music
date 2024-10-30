import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monopoli/screens/discover/index.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:palette_generator/palette_generator.dart';

class MusicPlayerPage extends StatefulWidget {
  final String imagePath; // Path to the local asset image
  final String musicTitle;
  final String artistName;

  MusicPlayerPage(
      {required this.imagePath,
      required this.musicTitle,
      required this.artistName
      });

  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  Color? dominantColor;
  Color? vibrantColor;

  Duration currentTime = Duration.zero; // Time consumed
  Duration totalTime = Duration(
      minutes: 3, seconds: 30); // Total duration of the song (for example)
  Timer? timer;
  bool isPlaying = true;
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
    _updateBackgroundColors();
    startTimer();
  }
  bool isMinimized = false;

  void togglePlayer() {
    setState(() {
      isMinimized = !isMinimized;
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited; // Toggle the state
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentTime < totalTime) {
        setState(() {
          currentTime += Duration(seconds: 1);
        });
      } else {
        timer.cancel();
      }
    });
  }

  void togglePlayPause() {
    if (isPlaying) {
      timer?.cancel(); // Pause the timer if playing
    } else {
      startTimer(); // Start the timer if paused
    }

    setState(() {
      isPlaying = !isPlaying; // Toggle play/pause state
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  // Function to update background colors based on the asset image
  Future<void> _updateBackgroundColors() async {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      AssetImage(widget.imagePath),
    );

    setState(() {
      dominantColor = paletteGenerator.darkVibrantColor?.color ?? Colors.black;
      vibrantColor = paletteGenerator.dominantColor?.color ?? grey;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.transparent,
      body: isMinimized ? Discover() : buildFullPlayer(),
      bottomNavigationBar: isMinimized ? buildBottomMiniPlayer() : null,
    );
  }

  Widget buildFullPlayer() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            (dominantColor ?? Colors.black).withOpacity(0.7), // 50% opacity
            (vibrantColor ?? grey!).withOpacity(0.9), // 50% opacity
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              IconButton(
                  onPressed: () {
                    togglePlayer();
                  },
                  icon: Icon(
                    FontAwesomeIcons.windowMinimize,
                    color: primaryWhite,
                  )),
              SizedBox(
                height: 40,
              ),
              // Music Image (Asset Image)
              Center(
                child: Image.asset(
                  widget.imagePath,
                  width: width * 0.7,
                  height: height * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30),
              // Music Title and Artist
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.musicTitle,
                        style: largeText(primaryWhite),
                      ),
                      Text(widget.artistName, style: mediumText(grey)),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      _isFavorited ? Icons.favorite : Icons.favorite_border,
                      // Change icon based on state
                      color: _isFavorited ? Colors.red : Colors.grey,
                      // Change color based on state
                      size: 40,
                    ),
                    onPressed: _toggleFavorite, // Call toggle function on tap
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Slider(
                      min: 0,
                      max: totalTime.inSeconds.toDouble(),
                      value: currentTime.inSeconds.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          currentTime = Duration(seconds: value.toInt());
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatDuration(currentTime), // Current time
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          formatDuration(totalTime), // Total time
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Music Controls (just icons for simplicity)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(FontAwesomeIcons.shuffle,
                        color: Colors.white, size: 25),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.backward,
                        color: Colors.white, size: 25),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      isPlaying
                          ? FontAwesomeIcons.pause
                          : FontAwesomeIcons
                          .play, // Toggle between play and pause
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: togglePlayPause,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.forward,
                        color: Colors.white, size: 25),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.repeat,
                        color: Colors.white, size: 25),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMiniPlayer() {
    return Center(
      child: ElevatedButton(
        onPressed: togglePlayer,
        child: Text("Open Full Player"),
      ),
    );
  }

  Widget buildBottomMiniPlayer() {
    return BottomAppBar(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: togglePlayer,
        child: Container(
          color: Colors.grey[900],
          padding: EdgeInsets.symmetric(horizontal: 20,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(widget.imagePath),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isPlaying
                          ? FontAwesomeIcons.pause
                          : FontAwesomeIcons
                          .play, // Toggle between play and pause
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: togglePlayPause,
                  ),
                  SizedBox(width: 10,),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.forward,
                        color: Colors.white, size: 25),
                    onPressed: () {},
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
