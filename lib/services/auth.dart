import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:twitter_login/twitter_login.dart';

class AuthService {
  static var auth = FirebaseAuth.instance;
  static var db = FirebaseFirestore.instance;

  static User? getUser() => auth.currentUser;

  static Future<UserCredential> login(
    String email,
    String password,
  ) {
    return auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Stream<User?> listenToAuth() => auth.authStateChanges();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> listenToUser() {
    var user = getUser();
    return db.collection('users').doc(user!.uid).snapshots();
  }

  static Future<UserCredential> register(
    String email,
    String password,
    String? username,
  ) async {
    var cred = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (username != null) {
      await cred.user?.updateDisplayName(username);
    }

    return cred;
  }

  static Future<void> deleteAccount() {
    var user = getUser()!;
    return user.delete();
  }

  static Future<void> resetPassword(String email) =>
      auth.sendPasswordResetEmail(email: email);

  static Future<void> logOut() => auth.signOut();

  static Future<UserCredential?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser?.authentication;

    if (googleAuth == null) {
      return null;
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await auth.signInWithCredential(credential);
  }

  static Future<UserCredential?> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) {
      return null;
    }

    final facebookAuthCredential = FacebookAuthProvider.credential(
      loginResult.accessToken!.tokenString,
    );

    return auth.signInWithCredential(facebookAuthCredential);
  }

  // static Future<UserCredential> signInWithTwitter() async {
  //   final twitterLogin = TwitterLogin(
  //     apiKey: 'NHNfZVRsdjl6RnNqMk5vdjBDazI6MTpjaQ',
  //     apiSecretKey: 'BX0Tgpi8iOHzXiQSxWDcn-FZPmGIvJTZFURNFhLDBasnIxhJXZ',
  //     redirectURI: 'https://monopoli-music.firebaseapp.com/__/auth/handler',
  //   );
  //
  //   final authResult = await twitterLogin.login();
  //
  //   final twitterAuthCredential = TwitterAuthProvider.credential(
  //     accessToken: authResult.authToken!,
  //     secret: authResult.authTokenSecret!,
  //   );
  //
  //   return await auth.signInWithCredential(twitterAuthCredential);
  // }

  static Future<void> createAccount({
    required User user,
    String? username,
    String? phone,
  }) {
    return db.collection('users').doc(user.uid).set({
      'id': user.uid,
      'username': username,
      'email': user.email,
      'phone': phone,
    });
  }

  static Future<void> sendVerificationEmail(String email) {
    var user = getUser()!;
    return user.sendEmailVerification();
  }

  static Future<void> updateUser(Map<String, dynamic> json) {
    var user = getUser()!;
    return db.collection('users').doc(user.uid).update(json);
  }
}
