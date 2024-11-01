import 'package:flutter/material.dart';
import 'package:monopoli/screens/search/gridview.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:monopoli/widgets/sheet/search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
                TextField(
                  readOnly: true,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      builder: (_) => const SearchSheet(),
                    );
                  },
                  // label: 'Artists, Songs, Album and more',
                  // textStyle: mediumText(primaryWhite),
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
                Container(
                  height: height,
                  width: width,
                  child: GenreGridPage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
