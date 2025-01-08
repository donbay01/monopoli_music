import 'package:flutter/material.dart';
import 'package:monopoli/screens/song/index.dart';
import 'package:monopoli/services/artist.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:zap_sizer/zap_sizer.dart';

class AllSongs extends StatelessWidget {
  final String? albumId;

  const AllSongs({
    super.key,
    this.albumId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            // isScrollControlled: true,
            showDragHandle: true,
            builder: (context) => SongUpload(
              albumId: albumId,
            ),
          ),
          child: Text('Add song'),
        ),
        SizedBox(
          height: 70.h,
          child: PaginateFirestore(
            shrinkWrap: true,
            itemBuilder: (context, snapshots, index) {
              var snap = snapshots[index];

              return Text(
                snap.id,
                style: mediumText(Colors.white),
              );
            },
            query: ArtistService.getMySongsInAlbum(albumId!),
            itemBuilderType: PaginateBuilderType.listView,
          ),
        ),
      ],
    );
  }
}
