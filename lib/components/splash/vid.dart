import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:monopoli/providers/player.dart';
import 'package:monopoli/screens/splashscreen/splash_screen.dart';
import 'package:video_player/video_player.dart';

class SplashVideo extends StatefulWidget {
  const SplashVideo({super.key});

  @override
  State<SplashVideo> createState() => _SplashVideoState();
}

class _SplashVideoState extends State<SplashVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/videos/splash_video.mp4',
    )
      ..initialize().then((_) async {
        await Future.delayed(const Duration(milliseconds: 1200));
        await _controller.play();
        setState(() {});

        await Future.delayed(const Duration(milliseconds: 3500), () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const SplashScreen(),
            ),
          );
        });
      })
      ..setLooping(false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#0f0f0f'),
      body: _controller.value.isInitialized
          ? Center(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
