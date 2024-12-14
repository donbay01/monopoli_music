import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monopoli/providers/spotify.dart';
import 'package:monopoli/screens/albums/index.dart';
import 'package:monopoli/screens/discover/album.dart';
import 'package:monopoli/screens/discover/all_album.dart';
import 'package:monopoli/screens/discover/hot_releases.dart';
import 'package:monopoli/screens/discover/top_music.dart';
import 'package:monopoli/screens/player/music_playing.dart';
import 'package:monopoli/services/spotify.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:monopoli/widgets/sheet/player.dart';
import 'package:monopoli/widgets/user/avatar.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:zap_sizer/zap_sizer.dart';
import '../../../providers/user_provider.dart';
import '../../widgets/user/profile_sheet.dart';

class Discover extends ConsumerStatefulWidget {
  const Discover({super.key});

  @override
  ConsumerState<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends ConsumerState<Discover>
    with TickerProviderStateMixin {
  var ids = [
    '6lI21W76LD0S3vC55GrfSS',
    '5Af7bJAiAKBCazSQU8BOsD',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    var user = ref.watch(userProvider);

    var t = ref.watch(spotifyToken);

    return Scaffold(
      backgroundColor: scaffoldBlack,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientText(
                    'Discover',
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                    colors: [purple, primaryWhite],
                  ),
                  if (user != null) ...[
                    UserAvatar(
                      user: user,
                    ),
                  ]
                ],
              ),
              // const FeaturedSongs(),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (t != null) ...[
                      TopMusic(
                        token: t,
                      ),
                    ],
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: height * 0.5,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/hotRelease.png'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Hot Releases',
                                    style: mediumSemiBold(primaryWhite),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: primaryWhite,
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 5,
                                        ),
                                        child: Text(
                                          'View all',
                                          style: smallText(primaryWhite),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (t != null) ...[
                                HotReleases(
                                  token: t,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending Album',
                    style: mediumSemiBold(primaryWhite),
                  ),
                  TextButton(
                    onPressed: () => pushScreen(
                      context,
                      screen: AllAlbum(
                        token: t!,
                      ),
                    ),
                    child: Text(
                      'View all',
                      style: mediumBold(purple),
                    ),
                  ),
                ],
              ),
              if (t != null) ...[
                Albums(
                  token: t,
                  ids: ids,
                )
              ],
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
