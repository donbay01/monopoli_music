import 'dart:convert';
import 'dart:io';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter/material.dart';
import 'package:monopoli/helper/snackbar.dart';
import 'package:monopoli/screens/player/index.dart';
import 'package:monopoli/screens/search/gridview.dart';
import 'package:monopoli/services/music.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:monopoli/widgets/form/textfield.dart';
import 'package:monopoli/widgets/user/avatar.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:zap_sizer/zap_sizer.dart';

import '../../models/audio/track.dart';
import '../player/music_playing.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  Future<List> fetchData() async {
    try {
      String _inputText = searchController.text;
      var res = await MusicService.search(_inputText);

      return res.tracks!.items;
    } on HttpException catch (e) {
      SnackbarHelper.displayToastMessage(
        context: context,
        message: e.message,
      );
      return [];
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: scaffoldBlack,
        body: Padding(
          padding: EdgeInsets.all(20),
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
                    Text(
                      'Search',
                      style: largeText(primaryWhite),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                TextFieldSearch(
                  label: 'Artists, Songs, Album and more',
                  controller: searchController,
                  textStyle: mediumText(primaryWhite),
                  decoration: InputDecoration(
                    labelText: 'Artists, Songs, Album and more',
                    labelStyle: medium(),
                    hintText: 'Artists, Songs, Album and more',
                    hintStyle: smallText(primaryWhite),
                    filled: true,
                    fillColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: purple,
                        width: 1.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                  future: () {
                    return fetchData();
                  },
                  getSelectedValue: (Track value) async {
                    context.loaderOverlay.show();
                    var audio = await MusicService.getTrackURL(value.id);
                    context.loaderOverlay.hide();
                    pushScreenWithoutNavBar(
                      context,
                      MusicPlayerPage(
                        audio: audio,
                        track: value,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Browse Categories',
                  style: mediumSemiBold(primaryWhite),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(height: height, width: width, child: GenreGridPage()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}