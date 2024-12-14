import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:monopoli/models/audio/index.dart';
import 'package:monopoli/models/audio/track.dart';

class UserService {
  static var db = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;

  static getSongsInPlaylist(String uid, String playlistId) {
    return db
        .collection('users')
        .doc(uid)
        .collection('tracks')
        .where('playlists', arrayContains: playlistId)
        .orderBy('timestamp');
  }

  User? firebaseUser() {
    return auth.currentUser;
  }

  static Future<DocumentReference<Map<String, dynamic>>> createPlaylist({
    required String uid,
    String? name,
  }) async {
    var ref = db
        .collection('users')
        .doc(uid)
        .collection('playlists')
        .doc(name ?? 'Hafsat');
    await ref.set({
      'name': name ?? 'Hafsat',
      'uid': uid,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return ref;
  }

  static getPlaylist(String uid) =>
      db.collection('users').doc(uid).collection('playlists').orderBy('name');

  static Future addSongToPlayList(
    String uid,
    String playlistId,
    String trackId,
  ) {
    return db
        .collection('users')
        .doc(uid)
        .collection('tracks')
        .doc(trackId)
        .update({
      'playlists': FieldValue.arrayUnion([playlistId])
    });
  }

  static Future removeSongFromPlayList(
    String uid,
    String playlistId,
    String trackId,
  ) {
    return db
        .collection('users')
        .doc(uid)
        .collection('tracks')
        .doc(trackId)
        .update({
      'playlists': FieldValue.arrayRemove([playlistId])
    });
  }

  static Future addSong(
    String uid,
    Track track,
    AudioApiResponse audio,
  ) {
    return db
        .collection('users')
        .doc(uid)
        .collection('tracks')
        .doc(track.id)
        .set(
      {
        'track': track.toJson(),
        'audio': audio.toJson(),
        'timestamp': FieldValue.serverTimestamp(),
        // 'playlists': [],
        // 'liked': false,
        // 'shared': false,
        // 'downloaded': false,
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  static Future removeSong(
    String uid,
    Track track,
  ) {
    return db
        .collection('users')
        .doc(uid)
        .collection('tracks')
        .doc(track.id)
        .delete();
  }

  static Future updateSong(
    String uid,
    String trackId,
    Map<String, dynamic> json,
  ) {
    return db
        .collection('users')
        .doc(uid)
        .collection('tracks')
        .doc(trackId)
        .update(
          json,
        );
  }

  static getLikedSong(String uid) =>
      db.collection('users').doc(uid).collection('tracks');

  static getDownloadedSong(String uid) => db
      .collection('users')
      .doc(uid)
      .collection('tracks')
      .where('downloaded', isEqualTo: true)
      .orderBy('timestamp', descending: true);

  static getSharedSong(String uid) => db
      .collection('users')
      .doc(uid)
      .collection('tracks')
      .where('shared', isEqualTo: true)
      .orderBy('timestamp', descending: true);

  static Future<void> likeSong(
    String uid,
    Track track,
    AudioApiResponse audio,
  ) async {
    await db
        .collection('users')
        .doc(uid)
        .collection('tracks')
        .doc(track.id)
        .update({
      'liked': true,
    });

    return db.collection('users').doc(uid).update({
      'liked': FieldValue.arrayUnion([track.id])
    });
  }

  static Future<void> unLikeSong(
    String uid,
    String trackId,
  ) {
    return db
        .collection('users')
        .doc(uid)
        .collection('tracks')
        .doc(trackId)
        .update({
      'liked': false,
    });
  }
}
