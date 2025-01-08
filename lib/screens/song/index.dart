import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:monopoli/services/artist.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/services/upload.dart';
import 'package:monopoli/widgets/form/textfield.dart';
import 'package:monopoli/widgets/progress/firebase_storage.dart';
import 'package:media_info/media_info.dart';

class SongUpload extends StatefulWidget {
  final String? albumId;

  const SongUpload({
    super.key,
    this.albumId,
  });

  @override
  State<SongUpload> createState() => _SongUploadState();
}

class _SongUploadState extends State<SongUpload> {
  var name = TextEditingController();
  var user = AuthService.getUser();

  UploadTask? task;
  PlatformFile? file;

  Future<String> uploadFile({
    required FileType type,
    required String path,
  }) async {
    file = await UploadService.pickMedia(
      type: type,
    );
    var ref = '$path/${file?.name ?? name.text}';

    var task = UploadService.uploadBytes(
      path: ref,
      data: file!.bytes!,
    );

    setState(() {});

    var snap = await task;
    var url = await snap.ref.getDownloadURL();

    return url;
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (task != null) ...[
            FirebaseStorageProgress(
              task: task,
            ),
          ],
          CustomTextField(
            controller: name,
            label: 'Name',
            hint: 'Enter song name',
          ),
          TextButton(
            onPressed: () async {
              uploadFile(
                type: FileType.audio,
                path: 'users/${user?.uid}/songs',
              );
            },
            child: Text('Upload song'),
          ),
          TextButton(
            onPressed: () async {
              MediaInfo _mediaInfo = MediaInfo();
              var res = await _mediaInfo.getMediaInfo(file!.path!);
              await ArtistService.createSong(
                name: name.text,
                albumId: widget.albumId,
                duration: res['durationMs'],
              );

              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
