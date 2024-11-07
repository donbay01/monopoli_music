import 'package:flutter/material.dart';
import 'package:monopoli/models/audio/index.dart';
import 'package:monopoli/models/audio/track.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/services/user.dart';
import 'package:monopoli/widgets/lists/music_tile.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:zap_sizer/zap_sizer.dart';

import '../../theme/colors.dart';
import '../../theme/text_style.dart';

class PlaylistDetail extends StatelessWidget {
  final String playlistId;
  final String playlistName;

  const PlaylistDetail({
    super.key,
    required this.playlistId,
    required this.playlistName,
  });

  @override
  Widget build(BuildContext context) {
    var user = AuthService.getUser();

    return Scaffold(
      backgroundColor: scaffoldBlack,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: primaryWhite,
          ),
        ),
        title: Text(
          playlistName,
          style: mediumSemiBold(primaryWhite),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.3.w,
        ),
        child: PaginateFirestore(
          shrinkWrap: true,
          isLive: true,
          separator: SizedBox(
            height: 1.4.h,
          ),
          itemBuilder: (context, snapshots, index) {
            var snap = snapshots[index];
            var audio = AudioApiResponse.fromJson(snap.get('audio'));
            var track = Track.fromJson(snap.get('track'));

            return MusicTile(
              audio: audio,
              track: track,
              userId: user.uid,
              isDownloaded: snap.get('downloaded'),
              isShared: snap.get('shared'),
            );
          },
          query: UserService.getSongsInPlaylist(
            user!.uid,
            playlistId,
          ),
          itemBuilderType: PaginateBuilderType.listView,
        ),
      ),
    );
  }
}
