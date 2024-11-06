import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monopoli/screens/library/playlist_detail.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/services/user.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:zap_sizer/zap_sizer.dart';

class Playlist extends ConsumerWidget {
  const Playlist({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    var user = AuthService.getUser();

    return PaginateFirestore(
      onEmpty: Center(
        child: Text(
          'No song has been added to the playlist',
          style: mediumText(Colors.white),
        ),
      ),
      separator: SizedBox(
        height: 1.5.h,
      ),
      itemBuilderType: PaginateBuilderType.listView,
      query: UserService.getPlaylist(user!.uid),
      isLive: true,
      shrinkWrap: true,
      itemBuilder: (context, snapshots, index) {
        var snap = snapshots[index];
        var name = snap.get('name');

        return GestureDetector(
          onTap: () => pushScreenWithNavBar(
            context,
            PlaylistDetail(
              playlistId: snap.id,
              playlistName: name,
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/launch.png',
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 3.w,
              ),
              Text(
                snap.get('name'),
                style: mediumSemiBold(
                  Colors.white,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
