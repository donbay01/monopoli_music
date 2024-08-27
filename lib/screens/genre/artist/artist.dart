import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:monopoli/theme/colors.dart';

import '../../../helper/snackbar.dart';
import '../../../services/auth.dart';
import '../../dashboard/index.dart';
import '../../onboard/getStarted.dart';
import '../../../theme/text_style.dart';
import '../../../widgets/button/genre_button.dart';

class ArtistSelectionPage extends StatefulWidget {
  const ArtistSelectionPage({super.key});

  @override
  _ArtistSelectionPageState createState() => _ArtistSelectionPageState();
}

class _ArtistSelectionPageState extends State<ArtistSelectionPage> {
  final List<String> topArtists = [
    'Burna Boy',
    'Davido',
    'Arya Star',
    'Wizkid',
    'Fire Boy',
    'Rema',
    'Tiwa Savage',
    'Olamide',
    'Run town',
  ];

  final List<String> allArtists = [
    'Taylor Swift',
    'Ed Sheeran',
    'Beyoncé',
    'Drake',
    'Adele',
    'Bruno Mars',
    'Billie Eilish',
    'The Weeknd',
    'Justin Bieber',
    'Kanye West',
    'Rihanna',
    'Lady Gaga',
    'Eminem',
    'Katy Perry',
    'Ariana Grande',
    'Shawn Mendes',
    'Dua Lipa',
    'Harry Styles',
    'Sam Smith',
    'Maroon 5',
    'Burna Boy',
    'Davido',
    'Arya Star',
    'Wizkid',
    'Fire Boy',
    'Rema',
    'Tiwa Savage',
    'Olamide',
    'Run town',
    // Add more artists as needed
  ];

  Set<String> selectedArtists = {};
  List<String> searchResults = [];
  TextEditingController searchController = TextEditingController();

  void onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        searchResults = [];
      } else {
        searchResults = allArtists
            .where((artist) =>
                artist.toLowerCase().contains(query.toLowerCase()) &&
                !topArtists.contains(artist))
            .toList();
      }
    });
  }

  void toggleSelection(String artist) {
    setState(() {
      if (selectedArtists.contains(artist)) {
        selectedArtists.remove(artist);
      } else if (selectedArtists.length < 3) {
        selectedArtists.add(artist);
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget buildArtistGrid() {
    if (searchController.text.isNotEmpty) {
      return Container(); // Return an empty container when searching
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: topArtists.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 5 / 3),
      itemBuilder: (context, index) {
        final artist = topArtists[index];
        final isSelected = selectedArtists.contains(artist);

        return GestureDetector(
          onTap: () => toggleSelection(artist),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? purple : Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
              border: GradientBoxBorder(
                gradient: LinearGradient(colors: [purple, primaryWhite]),
                width: 1,
              ),
            ),
            // color: isSelected ? purple : Colors.transparent,
            child: Center(
              child: Text(
                artist,
                textAlign: TextAlign.center,
                style: mediumText(primaryWhite),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSearchResults() {
    if (searchResults.isEmpty && searchController.text.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'No results found.',
          style: mediumText(primaryWhite),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final artist = searchResults[index];
        final isSelected = selectedArtists.contains(artist);

        return ListTile(
          title: Text(
            artist,
            style: mediumText(primaryWhite),
          ),
          trailing: Icon(
            isSelected ? Icons.check_box : Icons.check_box_outline_blank,
            color: isSelected ? purple : null,
          ),
          onTap: () => toggleSelection(artist),
        );
      },
    );
  }

  Widget buildSelectedArtists() {
    if (selectedArtists.isEmpty) return Container();

    return Wrap(
      spacing: 8.0,
      children: selectedArtists
          .map(
            (artist) => Chip(
              label: Text(artist),
              deleteIcon: Icon(
                Icons.close,
                color: primaryBlack,
              ),
              onDeleted: () => toggleSelection(artist),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/genre.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: primaryWhite,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Select your favourite artists',
                  style: mediumSemiBold(primaryWhite),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'You may select three (3) genres that matches your taste',
                  style: smallText(primaryWhite),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: searchController,
                  style: mediumText(primaryWhite),
                  decoration: InputDecoration(
                    labelText: 'Search for artists',
                    labelStyle: smallText(primaryWhite),
                    prefixIcon: Icon(
                      Icons.search,
                      color: primaryWhite,
                    ),
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
                  ),
                  onChanged: onSearchChanged,
                ),
                SizedBox(
                  height: 20,
                ),
                buildSelectedArtists(),
                SizedBox(height: 16.0),
                buildArtistGrid(),
                SizedBox(height: 16.0),
                Expanded(child: buildSearchResults()),
                GenreButton(
                  child: Text(
                    'Next',
                    style: mediumBold(primaryWhite),
                  ),
                  function: () async {
                    try {
                      context.loaderOverlay.show();
                      await AuthService.updateUser({
                        'favoriteArtists': selectedArtists,
                      });
                      context.loaderOverlay.hide();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Dashboard(),
                        ),
                        (route) => false,
                      );
                    } on FirebaseAuthException catch (e) {
                      context.loaderOverlay.hide();

                      SnackbarHelper.displayToastMessage(
                        context: context,
                        message: e.message!,
                      );
                    }
                  },
                ),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
