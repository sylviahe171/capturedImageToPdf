import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import '/save_and_open_pdf.dart';

class ImagePdfApi {
  static Future<File> generateImagePdf(List<String> _paths) async {
    final pdf = Document();

    final pageTheme = PageTheme(
      pageFormat: PdfPageFormat.a4,
    );
    for (var path in _paths) {
      Uint8List image1 = await File(path).readAsBytes();

      pdf.addPage(
        MultiPage(
          pageTheme: pageTheme,
          build: (context) => [
            Image(MemoryImage(image1)),
          ],
        ),
      );
    }

    return SaveAndOpenDocument.savePdf(name: 'image_pdf.pdf', pdf: pdf);
  }
}
