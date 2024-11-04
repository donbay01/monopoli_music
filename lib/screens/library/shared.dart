import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../../models/audio/index.dart';
import '../../models/audio/track.dart';
import '../../services/auth.dart';
import '../../services/user.dart';
import '../../widgets/lists/music_tile.dart';

class Shared extends ConsumerWidget {
  const Shared({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    var user = AuthService.getUser();

    return PaginateFirestore(
      itemBuilderType: PaginateBuilderType.listView,
      query: UserService.getSharedSong(user!.uid),
      isLive: true,
      shrinkWrap: true,
      itemBuilder: (context, snapshots, index) {
        var snap = snapshots[index];
        var a = snap.get('audio');
        var t = snap.get('track');

        var track = Track.fromJson(t);
        var res = AudioApiResponse.fromJson(a);

        return MusicTile(
          audio: res,
          track: track,
          userId: user.uid,
          isDownloaded: snap.get('downloaded'),
          isShared: snap.get('shared'),
        );
      },
    );
  }
}
