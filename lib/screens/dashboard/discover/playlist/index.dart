import 'package:flutter/material.dart';
import 'package:monopoli/models/home/top_content.dart';
import 'package:monopoli/screens/player/index.dart';
import 'package:monopoli/services/music.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:zap_sizer/zap_sizer.dart';

class PlaylistScreen extends StatelessWidget {
  final Playlist playlist;

  const PlaylistScreen({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBlack,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: primaryWhite,
            )),
        title: Text(
          playlist.name,
          style: mediumText(primaryWhite),
        ),
        backgroundColor: scaffoldBlack,
      ),
      body: FutureBuilder(
        future: MusicService.getPlayList(playlist.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return const Text('error');
          }

          var data = snapshot.data!;

          return ListView.separated(
            itemBuilder: (context, index) {
              var a = data.content!.items![index];

              return ListTile(
                onTap: () async {
                  var audio = await MusicService.getTrackURL(a.shareUrl!);
                  pushScreenWithoutNavBar(
                    context,
                    AppPlayer(audio: audio),
                  );
                },
                // leading: Text(a!.album!.cover!.first!.url),
                title: Text(
                  a.name ?? 'ssaa',
                  style: mediumText(primaryWhite),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 3.w,
            ),
            itemCount: data.content!.totalCount!,
          );
        },
      ),
    );
  }
}
