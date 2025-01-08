import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monopoli/screens/song/all.dart';
import 'package:monopoli/services/artist.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:zap_sizer/zap_sizer.dart';

class MyAlbums extends StatelessWidget {
  const MyAlbums({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      itemBuilderType: PaginateBuilderType.listView,
      isLive: true,
      shrinkWrap: true,
      query: ArtistService.getMyAlbums(),
      itemBuilder: (context, snapshots, index) {
        var snap = snapshots[index];

        return GestureDetector(
          onTap: () => showModalBottomSheet(
            useRootNavigator: true,
            isScrollControlled: true,
            showDragHandle: true,
            context: context,
            builder: (context) => AllSongs(
              albumId: snap.id,
            ),
          ),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: snap.get('cover'),
                fit: BoxFit.cover,
                height: 10.h,
                width: 10.h,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                snap.get('name'),
                style: mediumSemiBold(Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
