import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:monopoli/helper/snackbar.dart';
import 'package:monopoli/screens/onboard/carousal.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: scaffoldBlack,
            content: TextButton(
                onPressed: () async {
                  try {
                    await AuthService.logOut();
                    Navigator.pop(context);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => OnboardingCarousel(),
                      ),
                          (route) => false,
                    );
                  } on FirebaseException catch (e) {
                    SnackbarHelper.displayToastMessage(
                      context: context,
                      message: e.message!,
                    );
                  }
                },
                child: Text(
                  'Sign Out',
                  style: mediumBold(primaryWhite),
                )),
          ),
        );
      },
      child: CircleAvatar(
        child: Image(image: AssetImage('assets/avatar.png')),
      ),
    );
  }
}
