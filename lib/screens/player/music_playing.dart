import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:monopoli/models/audio/track.dart';
import 'package:monopoli/providers/player.dart';
import 'package:monopoli/providers/user_provider.dart';
import 'package:monopoli/screens/discover/index.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/services/user.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:zap_sizer/zap_sizer.dart';
import '../../models/audio/index.dart';

class MusicPlayerPage extends ConsumerStatefulWidget {
  final Track track;
  final AudioApiResponse audio;
  final Function() function;

  const MusicPlayerPage({
    required this.audio,
    required this.track,
    required this.function,
  });

  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends ConsumerState<MusicPlayerPage> {
  Color? dominantColor = Colors.black;
  Color? vibrantColor = Colors.grey;

  bool _isFavorited = false;

  late AudioPlayer _audioPlayer;
  late Duration totalTime = Duration.zero;
  late Duration currentTime = Duration.zero;
  bool isPlaying = false;

  void setupAudioPlayer() async {
    if (!isPlaying) {
      togglePlayPause();
    }

    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        setState(() {
          totalTime = duration;
        });
      }
    });

    _audioPlayer.positionStream.listen((position) {
      setState(() {
        currentTime = position;
      });
    });
  }

  @override
  void initState() {
    // var u = ref.read(userProvider);
    // _isFavorited = u?.liked.contains(widget.track.id) ?? false;
    // totalTime = Duration(
    //   milliseconds: widget.audio.youtubeVideo.audio.first.durationMs,
    // );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _audioPlayer = ref.read(player);
      isPlaying = _audioPlayer.playing;
      setupAudioPlayer();
      _updateBackgroundColors();
      ref.read(audioProvider.notifier).state = widget.audio;
      ref.read(trackProvider.notifier).state = widget.track;
    });
    super.initState();
  }

  void _toggleFavorite() {
    try {
      var user = AuthService.getUser();
      if (!_isFavorited) {
        UserService.likeSong(
          user!.uid,
          widget.track,
          widget.audio,
        );
      } else {
        UserService.unLikeSong(
          user!.uid,
          widget.track.id!,
        );
      }
      setState(() {
        _isFavorited = !_isFavorited;
      });
    } on FirebaseException catch (e) {
      print(e.message);
      Fluttertoast.showToast(
        msg: e.message!,
      );
    }
  }

  void togglePlayPause() {
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
      CachedNetworkImageProvider(
        widget.track.album?.cover?.first.url ??
            widget.track.album!.images!.first.url,
      ),
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
      body: buildFullPlayer(),
    );
  }

  Widget buildFullPlayer() {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return TweenAnimationBuilder(
      tween: ColorTween(begin: dominantColor, end: vibrantColor),
      duration: const Duration(seconds: 2),
      builder: (context, Color? color, child) {
        return AnimatedContainer(
          duration: const Duration(seconds: 2),
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                (dominantColor ?? Colors.black).withOpacity(0.7),
                (vibrantColor ?? Colors.grey).withOpacity(0.9),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.function();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: primaryWhite,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  Center(
                    child: Hero(
                      tag: Key(widget.track.id!),
                      child: CachedNetworkImage(
                        imageUrl: widget.track.album!.cover?.last.url ??
                            widget.track.album!.images!.first.url,
                        width: width * 0.7,
                        height: height * 0.3,
                        fit: BoxFit.contain,
                      ),
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
                            widget.track.name ?? 'N/A',
                            style: mediumBold(primaryWhite),
                          ),
                          Text(
                            widget.track.artists!.first.name ?? 'N/A',
                            style: mediumText(grey),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          _isFavorited ? Icons.favorite : Icons.favorite_border,
                          // Change icon based on state
                          color: _isFavorited ? Colors.red : Colors.grey,
                          // Change color based on state
                          size: 30,
                        ),
                        onPressed:
                            _toggleFavorite, // Call toggle function on tap
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        // Slider(
                        //   min: 0,
                        //   max: totalTime.inSeconds.toDouble(),
                        //   value: currentTime.inSeconds.toDouble(),
                        //   onChanged: (value) {
                        //     setState(() {
                        //       currentTime = Duration(seconds: value.toInt());
                        //       _audioPlayer.seek(currentTime);
                        //     });
                        //   },
                        // ),
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
                        onPressed: () {
                          var mode = _audioPlayer.loopMode;
                          LoopMode target;

                          if (mode == LoopMode.one) {
                            target = LoopMode.off;
                          } else {
                            target = LoopMode.one;
                          }

                          _audioPlayer.setLoopMode(target);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
