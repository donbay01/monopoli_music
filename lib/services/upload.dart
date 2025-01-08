import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime/mime.dart';

class UploadService {
  static var storage = FirebaseStorage.instance;

  static Future<PlatformFile?> pickMedia({
    required FileType type,
  }) async {
    var result = await FilePicker.platform.pickFiles(
      type: type,
      withData: true,
      allowMultiple: false,
    );

    if (result == null) return null;

    return result.files.first;
  }

  static Future<UploadTask> uploadFile({
    required String path,
    required File file,
  }) async {
    var ref = storage.ref().child(path);
    return ref.putFile(file);
  }

  static UploadTask uploadBytes({
    required String path,
    required Uint8List data,
  }) {
    var ref = storage.ref().child(path);
    final metadata = SettableMetadata(
      contentType: lookupMimeType(path),
    );
    return ref.putData(data, metadata);
  }
}
