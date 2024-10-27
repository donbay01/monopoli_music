import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:monopoli/screens/dashboard/discover/index.dart';
import 'package:monopoli/screens/dashboard/library/index.dart';
import 'package:monopoli/screens/dashboard/myLibrary.dart';
import 'package:monopoli/screens/dashboard/search/index.dart';
import 'package:monopoli/services/music.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      navBarHeight: 65,
      backgroundColor: primaryBlack,
      tabs: [
        PersistentTabConfig(
          screen: Discover(),
          item: ItemConfig(
            icon: const Icon(
              Icons.broadcast_on_personal_rounded,
              size: 25,
            ),
            title: "Discover",
            textStyle: small(),
            activeForegroundColor: purple,
          ),
        ),
        PersistentTabConfig(
          screen: SearchScreen(),
          item: ItemConfig(
            icon: const Icon(
              FontAwesomeIcons.search,
              size: 25,
            ),
            title: "Search",
            textStyle: small(),
            activeForegroundColor: purple,
          ),
        ),
        PersistentTabConfig(
          screen: const Mylibrary(),
          item: ItemConfig(
              icon: const Icon(
                Icons.library_music,
                size: 25,
              ),
              title: "Library",
              textStyle: small(),
              activeForegroundColor: purple),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style7BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(color: primaryBlack),
      ),
    );
  }
}
