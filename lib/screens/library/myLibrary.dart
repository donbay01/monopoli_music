import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monopoli/screens/library/albums.dart';
import 'package:monopoli/screens/library/downloaded.dart';
import 'package:monopoli/screens/library/liked.dart';
import 'package:monopoli/screens/library/shared.dart';
import 'package:monopoli/screens/library/song.dart';
import 'package:monopoli/screens/song/index.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/widgets/sheet/add_album.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:zap_sizer/zap_sizer.dart';
import './playlist.dart';
import '../../providers/user_provider.dart';
import '../../theme/text_style.dart';
import '../../widgets/user/avatar.dart';
import '../player/music_playing.dart';

class Mylibrary extends ConsumerStatefulWidget {
  const Mylibrary({super.key});

  @override
  ConsumerState<Mylibrary> createState() => _MylibraryState();
}

class _MylibraryState extends ConsumerState<Mylibrary> {
  String selectedText = 'Playlist';
  List<String> items = ['Playlist', 'Liked Songs', 'Downloaded', 'Shared'];

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      var user = ref.read(userProvider);
      if (user?.type == 'Artist') {
        items.addAll(['Albums', 'Songs']);
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: scaffoldBlack,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GradientText(
                  'Library',
                  style: const TextStyle(
                    fontSize: 25.0,
                  ),
                  colors: [purple, primaryWhite],
                ),
                if (user != null) ...[
                  UserAvatar(
                    user: user,
                  )
                ]
              ],
            ),
            SizedBox(
              width: 95.w,
              height: 10.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                separatorBuilder: (context, index) => SizedBox(
                  width: 3.w,
                ),
                itemBuilder: (context, index) {
                  bool isSelected = items[index] == selectedText;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedText = items[index];
                      });
                    },
                    child: Chip(
                      backgroundColor: isSelected ? primaryWhite : primaryBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        items[index],
                        style: smallText(
                          isSelected ? primaryBlack : primaryWhite,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Text(
              selectedText,
              style: mediumSemiBold(primaryWhite),
            ),
            const SizedBox(
              height: 50,
            ),
            if (selectedText == 'Playlist') ...[
              const Playlist(),
            ],
            if (selectedText == 'Liked Songs') ...[
              const Liked(),
            ],
            if (selectedText == 'Downloaded') ...[
              const Downloaded(),
            ],
            if (selectedText == 'Shared') ...[
              const Shared(),
            ],
            if (selectedText == 'Albums') ...[
              TextButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => const AddAlbum(),
                  useRootNavigator: true,
                  showDragHandle: true,
                ),
                child: Text('Add Album'),
              ),
              const MyAlbums(),
            ],
            if (selectedText == 'Songs') ...[
              const MySongs(),
            ],
          ],
        ),
      ),
    );
  }
}
