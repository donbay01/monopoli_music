import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monopoli/services/auth.dart';

class OAuthService {
  static googleAuth({
    Function()? completer,
  }) async {
    var cred = await AuthService.signInWithGoogle();
    await complete(credential: cred!);
    return completer;
  }

  static xAuth({
    Function()? completer,
  }) async {
    var cred = await AuthService.signInWithTwitter();
    await complete(credential: cred);
    return completer;
  }

  static facebookAuth({
    Function()? completer,
  }) async {
    var cred = await AuthService.signInWithFacebook();
    await complete(credential: cred!);
    return completer;
  }

  static Future? complete({
    required UserCredential credential,
    String? username,
  }) {
    if (credential.additionalUserInfo!.isNewUser) {
      return AuthService.createAccount(
        user: credential.user!,
        username: username,
      );
    }

    return null;
  }
}
