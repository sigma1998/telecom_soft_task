import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class RecordingService {
  static final record = AudioRecorder();

  static startPlaying() async {
    if (await record.hasPermission()) {
      Directory? path = await getDownloadsDirectory();
      await record.start(const RecordConfig(), path: '${path?.path}/recitation.m4a');
    }
  }

  static Future<String?> stop() async {
    return await record.stop();
  }
}
