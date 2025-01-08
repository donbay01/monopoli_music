import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../screens/discover/index.dart';
import '../screens/library/myLibrary.dart';
import '../screens/podcast/podcast.dart';
import '../screens/search/index.dart';
import '../theme/colors.dart';
import '../theme/text_style.dart';

var streamerTab = [
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
        size: 20,
      ),
      title: "Search",
      textStyle: small(),
      activeForegroundColor: purple,
    ),
  ),
  PersistentTabConfig(
    screen: PodcastPage(),
    item: ItemConfig(
      icon: const Icon(
        FontAwesomeIcons.podcast,
        size: 20,
      ),
      title: "Podcast",
      textStyle: small(),
      activeForegroundColor: purple,
    ),
  ),
  PersistentTabConfig(
    screen: const Mylibrary(),
    item: ItemConfig(
      icon: const Icon(
        Icons.library_music,
        size: 20,
      ),
      title: "Library",
      textStyle: small(),
      activeForegroundColor: purple,
    ),
  ),
];

var artistTab = [
  ...streamerTab,
  // PersistentTabConfig(
  //   screen: Container(),
  //   item: ItemConfig(
  //     icon: const Icon(
  //       Icons.music_note,
  //       size: 20,
  //     ),
  //     title: "My songs",
  //     textStyle: small(),
  //     activeForegroundColor: purple,
  //   ),
  // ),
];
