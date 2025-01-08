import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ArtistService {
  static var db = FirebaseFirestore.instance;
  static var auth = FirebaseAuth.instance;

  static var user = auth.currentUser;

  static getMyAlbums() => db
      .collection("users")
      .doc(user?.uid)
      .collection("albums")
      .orderBy("createdAt", descending: true);

  static Future createAlbum({
    required String name,
    String? coverImage,
  }) {
    return db.collection("users").doc(user?.uid).collection('albums').add({
      'name': name,
      'uid': user?.uid,
      'cover': coverImage,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static getMySongs() => db
      .collection("users")
      .doc(user?.uid)
      .collection("songs")
      .orderBy("createdAt", descending: true);

  static Future createSong({
    required String name,
    String? albumId,
    int? duration,
  }) {
    return db.collection("users").doc(user?.uid).collection('songs').add({
      'name': name,
      'uid': user?.uid,
      'albumId': albumId,
      'duration': duration,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
