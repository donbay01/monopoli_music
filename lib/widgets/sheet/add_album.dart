import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:monopoli/services/artist.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/services/upload.dart';
import 'package:monopoli/widgets/form/textfield.dart';
import 'package:monopoli/widgets/progress/firebase_storage.dart';

class AddAlbum extends StatefulWidget {
  const AddAlbum({super.key});

  @override
  State<AddAlbum> createState() => _SongUploadState();
}

class _SongUploadState extends State<AddAlbum> {
  var name = TextEditingController();
  var user = AuthService.getUser();

  PlatformFile? file;
  UploadTask? task;
  String? url;

  Future<String?> uploadFile({
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
    url = await snap.ref.getDownloadURL();

    return url;
  }

  save() async {
    await ArtistService.createAlbum(
      name: name.text,
      coverImage: url,
    );
    Navigator.of(context).pop();
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
            hint: 'Enter album name',
          ),
          if (file == null) ...[
            TextButton(
              onPressed: () async {
                uploadFile(
                  type: FileType.image,
                  path: 'users/${user?.uid}/albums',
                );
              },
              child: Text('Upload Cover album image'),
            ),
          ] else ...[
            Image.file(
              File(file!.path!),
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ],
          TextButton(
            onPressed: save,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
