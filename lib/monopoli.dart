import 'package:flutter/material.dart';
import 'package:monopoli/splashscreen/splash_screen.dart';

class Monopoli extends StatefulWidget {
  const Monopoli({super.key});

  @override
  State<Monopoli> createState() => _MonopoliState();
}

class _MonopoliState extends State<Monopoli> {
  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
