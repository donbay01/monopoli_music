import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monopoli/models/audio/index.dart';
import 'package:monopoli/models/audio/track.dart';

class UserService {
  static var db = FirebaseFirestore.instance;

  static getLikedSong(String uid) => db
      .collection('users')
      .doc(uid)
      .collection('liked')
      .orderBy('timestamp', descending: true);

  static Future<void> likeSong(
    String uid,
    Track track,
    AudioApiResponse audio,
  ) async {
    await db
        .collection('users')
        .doc(uid)
        .collection('liked')
        .doc(track.id)
        .set({
      'timestamp': FieldValue.serverTimestamp(),
      'track': track.toJson(),
      'audio': audio.toJson(),
    });

    return db.collection('users').doc(uid).update({
      'liked': FieldValue.arrayUnion([track.id])
    });
  }

  static Future<void> unLikeSong(
    String uid,
    String trackId,
  ) async {
    await db
        .collection('users')
        .doc(uid)
        .collection('liked')
        .doc(trackId)
        .delete();

    return db.collection('users').doc(uid).update({
      'liked': FieldValue.arrayRemove([trackId])
    });
  }
}
