import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:monopoli/screens/player/index.dart';
import 'package:monopoli/services/music.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:monopoli/widgets/form/textfield.dart';
import 'package:monopoli/widgets/user/avatar.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:zap_sizer/zap_sizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  Future<List> fetchData() async {
    String _inputText = searchController.text;
    var res = await MusicService.search(_inputText);

    return res.tracks!.items.map((a) => a.name).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        color: scaffoldBlack,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Search',
                      style: largeText(primaryWhite),
                    ),
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage('assets/logoCircle.png'),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                TextFieldSearch(
                  label: 'Artists, Songs, Album and more',
                  controller: searchController,
                  future: () {
                    // return fetchData();
                  },
                  getSelectedValue: (value) async {
                    print(
                      value,
                    );
                    var audio = await MusicService.getTrackURL(value);
                    pushScreenWithoutNavBar(
                      context,
                      AppPlayer(audio: audio),
                    );
                  },
                ),
                // CustomTextField(
                //   controller: searchController,
                //   label: 'Search',
                //   hint: 'Artists, Songs, Album and more',
                //   prefixIcon: Icon(Icons.search),
                // ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Recommendations',
                  style: mediumSemiBold(primaryWhite),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
