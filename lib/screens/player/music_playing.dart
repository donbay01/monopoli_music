import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:monopoli/models/audio/track.dart';
import 'package:monopoli/screens/discover/index.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../models/audio/index.dart';

class MusicPlayerPage extends StatefulWidget {
  final Track track;
  final AudioApiResponse audio;

  const MusicPlayerPage({
    required this.audio,
    required this.track,
  });

  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  Color? dominantColor;
  Color? vibrantColor;

  Timer? timer;
  bool _isFavorited = false;

  AudioPlayer _audioPlayer = AudioPlayer();
  late Duration totalTime = Duration.zero;
  late Duration currentTime = Duration.zero;
  bool isMinimized = false;
  bool isPlaying = false;

  void setupAudioPlayer() async {
    try {
      await _audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(
            widget.audio.youtubeVideo.audio.first.url,
          ),
          tag: MediaItem(
            id: widget.track.id,
            album: widget.track.album.name,
            title: widget.track.name,
            artUri: Uri.parse(
              widget.track.album.cover!.first.url,
            ),
          ),
        ),
      );
      totalTime = _audioPlayer.duration ?? Duration.zero;
      setState(() {});
      _audioPlayer.positionStream.listen((position) {
        setState(() {
          currentTime = position;
        });
      });
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void initState() {
    setupAudioPlayer();
    super.initState();
    _updateBackgroundColors();
    startTimer();
  }

  void togglePlayer() {
    setState(() {
      isMinimized = !isMinimized;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
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
    // if (isPlaying) {
    //   timer?.cancel(); // Pause the timer if playing
    // } else {
    //   startTimer(); // Start the timer if paused
    // }

    // setState(() {
    //   isPlaying = !isPlaying; // Toggle play/pause state
    // });

    setState(() {
      isPlaying = !isPlaying;
    });
    isPlaying ? _audioPlayer.play() : _audioPlayer.pause();
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
      CachedNetworkImageProvider(widget.track.album.cover!.first.url),
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
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

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
<<<<<<< HEAD
                onPressed: () {
                  togglePlayer();
                },
                icon: Icon(
                  FontAwesomeIcons.windowMinimize,
                  color: primaryWhite,
                ),
              ),
=======
                  onPressed: () {
                    togglePlayer();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: primaryWhite,
                  )),
>>>>>>> 646bee90b28c6469d094a8a5804653e0bca36662
              SizedBox(
                height: 40,
              ),
              // Music Image (Asset Image)
              CachedNetworkImage(
                imageUrl: widget.track.album.cover!.first.url,
                width: width * 0.7,
                height: height * 0.3,
                fit: BoxFit.cover,
              ),
              // Center(
              //   child: Image.asset(
              //     widget.imagePath,
              //     width: width * 0.7,
              //     height: height * 0.3,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              const SizedBox(height: 30),
              // Music Title and Artist
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.track.name,
                        style: largeText(primaryWhite),
                      ),
                      Text(widget.track.artists.first.name,
                          style: mediumText(grey)),
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
                          _audioPlayer.seek(currentTime);
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
                          : FontAwesomeIcons.play,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: togglePlayPause,
                  ),
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.forward,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.repeat,
                      color: Colors.white,
                      size: 25,
                    ),
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
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.track.album.cover != null) ...[
                CachedNetworkImage(
                  imageUrl: widget.track.album.cover!.first.url,
                ),
              ],
              // CircleAvatar(
              //   backgroundImage: AssetImage(widget.imagePath),
              // ),
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
                  SizedBox(
                    width: 10,
                  ),
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
