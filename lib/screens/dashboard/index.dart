import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:monopoli/screens/dashboard/discover/index.dart';
import 'package:monopoli/screens/dashboard/library/index.dart';
import 'package:monopoli/screens/dashboard/search/index.dart';
import 'package:monopoli/services/music.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: const Discover(),
            item: ItemConfig(
              icon: const Icon(Icons.home),
              title: "Discover",
            ),
          ),
          PersistentTabConfig(
            screen: SearchScreen(),
            item: ItemConfig(
              icon: const Icon(Icons.message),
              title: "Search",
            ),
          ),
          PersistentTabConfig(
            screen: const Library(),
            item: ItemConfig(
              icon: const Icon(Icons.settings),
              title: "Library",
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style7BottomNavBar(
          navBarConfig: navBarConfig,
        ),
      ),
    );
  }
}
