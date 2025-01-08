import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorageProgress extends StatelessWidget {
  final UploadTask? task;

  const FirebaseStorageProgress({
    super.key,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    if (task == null) {
      return const SizedBox.shrink();
    }

    return StreamBuilder(
      stream: task!.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }

        if (snapshot.hasError) {
          return const Text('An error occurred');
        }

        var data = snapshot.data!;

        final progress = data.bytesTransferred / data.totalBytes;

        return LinearProgressIndicator(
          value: progress,
        );
      },
    );
  }
}
