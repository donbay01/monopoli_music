import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:monopoli/screens/splashscreen/splash_screen.dart';
import 'package:zap_sizer/zap_sizer.dart';

class Monopoli extends StatefulWidget {
  const Monopoli({super.key});

  @override
  State<Monopoli> createState() => _MonopoliState();
}

class _MonopoliState extends State<Monopoli> {
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: ZapSizer(
        builder: (context, constraints) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Monopoli',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
