import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:monopoli/providers/player.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/services/config.dart';

class AuthPlayer extends ConsumerStatefulWidget {
  const AuthPlayer({super.key});

  @override
  ConsumerState<AuthPlayer> createState() => _AuthPlayerState();
}

class _AuthPlayerState extends ConsumerState<AuthPlayer>
    with WidgetsBindingObserver {
  StreamSubscription<User?>? sub;
  AudioPlayer? _player;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    init();
    super.initState();
  }

  init() async {
    await RemoteConfigService.activate();
    var audioUrl = RemoteConfigService.config.getString('backgroundAudio');
    _player = ref.read(player);

    await _player?.setAudioSource(
      AudioSource.uri(
        Uri.parse(audioUrl),
        tag: const MediaItem(
          id: '1',
          album: "Desthim",
          title: "Desthim",
        ),
      ),
    );

    await _player?.setVolume(0.11);

    sub = AuthService.auth.authStateChanges().listen((u) {
      if (u != null) {
        _player?.stop();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var user = AuthService.getUser();

    if (state == AppLifecycleState.hidden) {
      _player?.pause();
    }

    if (state == AppLifecycleState.resumed && user == null) {
      _player?.play();
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _player?.dispose();
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
