import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import '/save_and_open_pdf.dart';

class ImagePdfApi {
  static Future<File> generateImagePdf(String path) async {
    final pdf = Document();

    Uint8List image1 = await File(path).readAsBytes();

    final pageTheme = PageTheme(
        pageFormat: PdfPageFormat.a4,
        buildBackground: (context) {
          if (context.pageNumber == 2) {
            return FullPage(
                ignoreMargins: true,
                child: Image(
                  MemoryImage(image1),
                  fit: BoxFit.cover,
                ));
          } else {
            return Container();
          }
        });

    pdf.addPage(
      MultiPage(
        pageTheme: pageTheme,
        build: (context) => [
          Image(MemoryImage(image1)),
        ],
      ),
    );

    return SaveAndOpenDocument.savePdf(name: 'image_pdf.pdf', pdf: pdf);
  }
}
