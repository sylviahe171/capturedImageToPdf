import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';

class SaveDocument {
  static Future<File> savePdf({
    required String name,
    required Document pdf,
  }) async {
    final root = await getExternalStorageDirectory();
    final file = File('${root!.path}/$name');
    await file.writeAsBytes(await pdf.save());
    debugPrint('${root.path}/$name');
    return file;
  }
}
