import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:monopoli/helper/snackbar.dart';
import 'package:monopoli/screens/auth/forgot_password.dart';
import 'package:monopoli/screens/dashboard/index.dart';
import 'package:monopoli/screens/onboard/getStarted.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:monopoli/widgets/button/genre_button.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'artist/artist.dart';

class GenreSelectionPage extends StatefulWidget {
  const GenreSelectionPage({super.key});

  @override
  _GenreSelectionPageState createState() => _GenreSelectionPageState();
}

class _GenreSelectionPageState extends State<GenreSelectionPage> {
  final List<String> genres = [
    'Afro-Beats',
    'Pop',
    'Jazz',
    'Hip Hop',
    'Classical',
    'Rock',
    'Reggae',
    'Country',
    'Blues',
  ];

  final Map<String, bool> selectedGenres = {};
  static const int maxSelection = 3;

  @override
  void initState() {
    super.initState();
    genres.forEach((genre) {
      selectedGenres[genre] = false; // Initialize all as unselected
    });
  }

  int getSelectedCount() {
    return selectedGenres.values.where((isSelected) => isSelected).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/onboarding.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Dashboard(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
              Text(
                'What Genres do you like?',
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
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 columns
                    mainAxisSpacing: 25.0,
                    crossAxisSpacing: 25.0,
                    childAspectRatio: 3 / 3,
                  ),
                  itemCount: genres.length,
                  itemBuilder: (context, index) {
                    final genre = genres[index];
                    return GestureDetector(
                      onTap: () {
                        if (selectedGenres[genre] == true ||
                            getSelectedCount() < maxSelection) {
                          setState(() {
                            selectedGenres[genre] = !selectedGenres[genre]!;
                          });
                        } else {
                          SnackbarHelper.displayToastMessage(
                              context: context,
                              message:
                                  'You can only select up to $maxSelection genres.');
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedGenres[genre]!
                              ? purple
                              : purple.withOpacity(0.1),
                        ),
                        child: Center(
                          child: Text(
                            genre,
                            style: mediumBold(selectedGenres[genre]!
                                ? primaryBlack
                                : primaryWhite),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              GenreButton(
                child: Text(
                  'Next',
                  style: mediumBold(primaryBlack),
                ),
                function: () async {
                  try {
                    context.loaderOverlay.show();
                    List<String> keysList = selectedGenres.keys
                        .where((key) => selectedGenres[key] == true)
                        .toList();
                    await AuthService.updateUser({'favoriteGenres': keysList});
                    context.loaderOverlay.hide();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ArtistSelectionPage(),
                      ),
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
              SizedBox(height: 10.0),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ArtistSelectionPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Skip',
                    style: mediumBold(purple),
                  )),
              SizedBox(height: 70.0),
            ],
          ),
        ),
      ),
    );
  }
}
