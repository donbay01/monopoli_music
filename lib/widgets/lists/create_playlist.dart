import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monopoli/models/audio/track.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:monopoli/widgets/button/formbutton.dart';
import 'package:monopoli/widgets/button/primary_button.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../services/user.dart';

class CreatePlaylist extends StatefulWidget {
  final Track track;

  const CreatePlaylist({
    super.key,
    required this.track,
  });

  @override
  State<CreatePlaylist> createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  var name = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  save() async {
    if (name.text.isEmpty) {
      return Fluttertoast.showToast(
        msg: 'You need to a name',
      );
    }

    try {
      var user = AuthService.getUser();
      context.loaderOverlay.show();
      var ref = await UserService.createPlaylist(
        uid: user!.uid,
        name: name.text,
      );
      await UserService.addSongToPlayList(
        user!.uid,
        ref.id,
        widget.track.id!,
      );
      context.loaderOverlay.hide();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      context.loaderOverlay.hide();
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.5.w),
        child: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            Text(
              'Create a new playlist',
              style: mediumSemiBold(Colors.white),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextFormField(
              style: mediumText(Colors.white),
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(
              height: 3.5.h,
            ),
            CustomButton(
              function: () => save(),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
