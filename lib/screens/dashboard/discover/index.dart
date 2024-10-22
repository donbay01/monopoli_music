import 'package:flutter/material.dart';
import 'package:monopoli/screens/dashboard/discover/featured_songs.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:monopoli/widgets/user/avatar.dart';
import 'package:zap_sizer/zap_sizer.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    var tags = ['All', 'Afrobeats', 'Gospel', 'Hip/Hop'];

    return Scaffold(
      backgroundColor: scaffoldBlack,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          primary: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const UserAvatar(),
                  SizedBox(
                    width: 65.w,
                    height: 10.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Chip(
                          backgroundColor: grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: Text(
                            tags[index],
                            style: mediumBold(primaryWhite),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        width: 3.w,
                      ),
                      itemCount: tags.length,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Trending Playlists',style: mediumSemiBold(primaryWhite),),
              // const FeaturedSongs(),
            ],
          ),
        ),
      ),
    );
  }
}
