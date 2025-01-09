import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:monopoli/constants/tabs.dart';
import 'package:monopoli/providers/nav.dart';
import 'package:monopoli/providers/player.dart';
import 'package:monopoli/providers/user_provider.dart';
import 'package:monopoli/screens/discover/index.dart';
import 'package:monopoli/screens/library/myLibrary.dart';
import 'package:monopoli/screens/podcast/podcast.dart';
import 'package:monopoli/screens/search/index.dart';
import 'package:monopoli/services/music.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:monopoli/widgets/sheet/player.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:zap_sizer/zap_sizer.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    // var showNav = ref.watch(navShowing);

    return Stack(
      children: [
        Consumer(
          builder: (context, ref, _) {
            var user = ref.watch(userProvider);

            if (user == null) {
              return const SizedBox.shrink();
            }

            return PersistentTabView(
              // navBarHeight: showNav ? 65 : 0,
              backgroundColor: primaryBlack,
              // hideNavigationBar: !showNav,
              tabs: user.type == 'Artist' ? artistTab : streamerTab,
              margin: EdgeInsets.zero,
              avoidBottomPadding: true,
              resizeToAvoidBottomInset: false,
              // floatingActionButtonLocation:
              //     FloatingActionButtonLocation.centerFloat,
              // floatingActionButton: const MusicPlayerSheet(),
              navBarBuilder: (navBarConfig) => Style7BottomNavBar(
                navBarConfig: navBarConfig,
                navBarDecoration: const NavBarDecoration(color: primaryBlack),
              ),
            );
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 10.h,
          child: const MusicPlayerSheet(),
        ),
      ],
    );
  }
}
