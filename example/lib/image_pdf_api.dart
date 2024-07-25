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

      //dumb way to avoid width or height of the image out of bound
      try {
        pdf.addPage(
          MultiPage(
            pageTheme: pageTheme,
            build: (context) => [
              Image(MemoryImage(image1),
                  width: pageTheme.pageFormat.availableWidth - 1)
            ],
          ),
        );
      } catch (e) {
        pdf.addPage(
          MultiPage(
            pageTheme: pageTheme,
            build: (context) => [
              Image(MemoryImage(image1),
                  height: pageTheme.pageFormat.availableHeight - 1)
            ],
          ),
        );
      }
    }

    return SaveAndOpenDocument.savePdf(name: 'image_pdf.pdf', pdf: pdf);
  }
}
