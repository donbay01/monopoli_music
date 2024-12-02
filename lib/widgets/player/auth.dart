import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/services/config.dart';

class AuthPlayer extends StatefulWidget {
  const AuthPlayer({super.key});

  @override
  State<AuthPlayer> createState() => _AuthPlayerState();
}

class _AuthPlayerState extends State<AuthPlayer> with WidgetsBindingObserver {
  StreamSubscription<User?>? sub;
  final player = AudioPlayer();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    init();
    super.initState();
  }

  init() async {
    await RemoteConfigService.activate();
    var audioUrl = RemoteConfigService.config.getString('backgroundAudio');

    sub = AuthService.auth.authStateChanges().listen((user) async {
      if (user != null) {
        player.stop();
      } else {
        await player.setAudioSource(
          AudioSource.uri(
            Uri.parse(audioUrl),
            tag: const MediaItem(
              id: '1',
              album: "Desthim",
              title: "Desthim",
            ),
          ),
        );

        await player.setVolume(0.11);

        await player.play();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var user = AuthService.getUser();

    if (state == AppLifecycleState.hidden) {
      player.pause();
    }

    if (state == AppLifecycleState.resumed && user == null) {
      player.play();
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    player.dispose();
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
