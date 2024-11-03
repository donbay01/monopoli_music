import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monopoli/screens/dashboard/index.dart';
import 'package:monopoli/screens/genre/index.dart';
import 'package:monopoli/services/auth.dart';

class OAuthService {
  static googleAuth({
    required BuildContext context,
    Function()? completer,
  }) async {
    var cred = await AuthService.signInWithGoogle();
    await complete(
      context: context,
      credential: cred!,
    );
    return completer;
  }

  // static xAuth({
  //   required BuildContext context,
  //   Function()? completer,
  // }) async {
  //   var cred = await AuthService.signInWithTwitter();
  //   await complete(
  //     context: context,
  //     credential: cred,
  //   );
  //   return completer;
  // }

  static facebookAuth({
    required BuildContext context,
    Function()? completer,
  }) async {
    var cred = await AuthService.signInWithFacebook();
    await complete(
      context: context,
      credential: cred!,
    );
    return completer;
  }

  static Future? complete({
    required BuildContext context,
    required UserCredential credential,
    String? username,
  }) async {
    if (credential.additionalUserInfo!.isNewUser) {
      await AuthService.createAccount(
        user: credential.user!,
        username: username,
      );

      return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const GenreSelectionPage()),
        (route) => false,
      );
    }

    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const Dashboard()),
      (route) => false,
    );
  }
}
