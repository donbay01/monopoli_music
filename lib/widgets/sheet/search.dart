import 'package:cached_network_image/cached_network_image.dart';
import 'package:debounce_textfield/debounce_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monopoli/providers/player.dart';
import 'package:monopoli/services/music.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:zap_sizer/zap_sizer.dart';
import '../../models/audio/models.dart';
import '../../theme/text_style.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SearchSheet extends ConsumerStatefulWidget {
  const SearchSheet({super.key});

  @override
  ConsumerState<SearchSheet> createState() => _SearchSheetState();
}

class _SearchSheetState extends ConsumerState<SearchSheet> {
  bool loading = false;
  ResponseData? results;

  search(String query) async {
    FocusScope.of(context).unfocus();

    setState(() {
      loading = true;
    });
    results = await MusicService.search(query);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      appBar: AppBar(
        backgroundColor: primaryBlack,
        automaticallyImplyLeading: false,
        title: DebounceTextfield(
          duration: const Duration(milliseconds: 600),
          action: (enteredText) {
            search(enteredText);
          },
          height: 50,
          clearButtonIcon: const Icon(
            Icons.clear_rounded,
            color: Colors.white,
            size: 20,
          ),
          textFieldDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: primaryBlack,
          ),
          inputDecoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search for your Artists, Songs, Album and more',
            hintStyle: mediumText(primaryWhite),
          ),
          textFieldStyle: mediumText(primaryWhite),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var track = results!.tracks!.items[index];

                return GestureDetector(
                  onTap: () async {
                    context.loaderOverlay.show();
                    var audio = await MusicService.getTrackURL(track.id);
                    ref.read(audioProvider.notifier).state = audio;
                    ref.read(trackProvider.notifier).state = track;
                    context.loaderOverlay.hide();
                    Navigator.of(context).pop();
                    // pushScreenWithoutNavBar(
                    //   context,
                    //   MusicPlayerPage(
                    //     audio: audio,
                    //     track: value,
                    //   ),
                    // );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.5.h),
                          child: CachedNetworkImage(
                            imageUrl: track.album.cover!.last.url,
                            fit: BoxFit.cover,
                            height: 5.5.h,
                            width: 5.5.h,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 60.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                track.name,
                                overflow: TextOverflow.ellipsis,
                                style: mediumSemiBold(Colors.white),
                              ),
                              Text(
                                track.artists.first.name,
                                style: mediumText(
                                  Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 1.3.h,
              ),
              itemCount: results?.tracks?.items.length ?? 0,
            ),
    );
  }
}
