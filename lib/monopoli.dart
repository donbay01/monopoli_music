import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:monopoli/providers/player.dart';
import 'package:monopoli/screens/dashboard/index.dart';
import 'package:monopoli/screens/splashscreen/splash_screen.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:zap_sizer/zap_sizer.dart';

class Monopoli extends ConsumerStatefulWidget {
  const Monopoli({super.key});

  @override
  ConsumerState<Monopoli> createState() => _MonopoliState();
}

class _MonopoliState extends ConsumerState<Monopoli> {
  @override
  void dispose() {
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
            title: 'DestHim',
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
