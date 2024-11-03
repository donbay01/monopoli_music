import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:monopoli/models/user/user_model.dart';
import 'package:monopoli/providers/player.dart';
import 'package:monopoli/providers/spotify.dart';
import 'package:monopoli/providers/user_provider.dart';
import 'package:monopoli/screens/dashboard/index.dart';
import 'package:monopoli/screens/splashscreen/splash_screen.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/services/music.dart';
import 'package:monopoli/services/spotify.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:zap_sizer/zap_sizer.dart';

class Monopoli extends ConsumerStatefulWidget {
  const Monopoli({super.key});

  @override
  ConsumerState<Monopoli> createState() => _MonopoliState();
}

class _MonopoliState extends ConsumerState<Monopoli> {
  StreamSubscription? sub;

  connection() async {
    var token = await Spotify.getSpotifyAuthToken();
    ref.read(spotifyToken.notifier).state = token;
  }

  @override
  void initState() {
    connection();
    AuthService.listenToAuth().listen((user) {
      if (user != null) {
        sub = AuthService.listenToUser().listen((event) {
          if (event.exists) {
            var data = event.data() as dynamic;
            ref.read(userProvider.notifier).state = UserModel.fromJSON(data);
          }
        });
      } else {
        ref.read(userProvider.notifier).state = null;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sub?.cancel();
    ref.read(player).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = AuthService.getUser();

    return GlobalLoaderOverlay(
      child: ZapSizer(
        builder: (context, constraints) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Desthim',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: purple),
              useMaterial3: true,
            ),
            home: Stack(
              children: [
                user == null ? const SplashScreen() : const Dashboard(),
                // const AuthPlayer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
