import 'package:flutter/material.dart';
import 'package:monopoli/services/artist.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class MySongs extends StatelessWidget {
  const MySongs({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      itemBuilderType: PaginateBuilderType.listView,
      isLive: true,
      shrinkWrap: true,
      query: ArtistService.getMySongs(),
      itemBuilder: (context, snapshots, index) {
        var snap = snapshots[index];

        return Text(snap.id);
      },
    );
  }
}
