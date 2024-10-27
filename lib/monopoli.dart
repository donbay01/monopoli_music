import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:monopoli/screens/dashboard/index.dart';
import 'package:monopoli/screens/splashscreen/splash_screen.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:zap_sizer/zap_sizer.dart';

class Monopoli extends StatefulWidget {
  const Monopoli({super.key});

  @override
  State<Monopoli> createState() => _MonopoliState();
}

class _MonopoliState extends State<Monopoli> {
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
