import 'package:flutter/material.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'dart:io';
import '../theme_constants.dart';
import 'generate_pdf_page.dart';
import '../image_pdf_api.dart';

import 'package:flutter_svg/flutter_svg.dart';

class ScanNoticePage extends StatefulWidget {
  String websiteLink;
  ScanNoticePage(this.websiteLink, {super.key});

  @override
  State<ScanNoticePage> createState() => _ScanNoticePageState();
}

class _ScanNoticePageState extends State<ScanNoticePage> {
  late File imagePdf;

  List<String> scannedPictures = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(children: [
          backgroundWidget(),
          Container(
              padding: const EdgeInsets.all(40),
              child: Column(children: [
                const SizedBox(height: 40),
                SvgPicture.asset('assets/icons/square-info.svg',
                    width: 100, height: 100, color: const Color(0xFF11ad8f)),
                const SizedBox(height: 10),
                const Text("注意事项",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                const SizedBox(height: 25),
                const Text(
                  "請嚴格遵照以下步驟上載答卷\n否則評語的質量有機會受到影響",
                  style: TextStyle(fontSize: 14, color: Color(0xFF9095A1)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                const Divider(),
                const SizedBox(height: 35),
                const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1. 【極重要】裁去邊框以外的所有文字(包括學校名稱、學生名稱等一切非文章內容的資訊)，只留下邊框內的方格字",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "2.  小心檢查 PDF 是否已經包含作文的所有頁面",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                const SizedBox(height: 65),
                startScanButton()
              ]))
        ]));
  }

  ElevatedButton startScanButton() {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
            const Size(350, 45)), // Set width and height of the button
      ),
      child: const Text("開始掃描",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
    );
  }

  void onPressed() async {
    List<String> picturesCollected;
    try {
      picturesCollected = await CunningDocumentScanner.getPictures() ?? [];
      if (!mounted) return;
      setState(() {
        scannedPictures = picturesCollected;
      });

      if (scannedPictures.isNotEmpty) {
        // Navigate to AnotherPage after executing the above operations
        imagePdf = await ImagePdfApi.generateImagePdf(scannedPictures);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GeneratePdfPage(
                  widget.websiteLink, scannedPictures,
                  generatedPdf: imagePdf)),
        );
      }
    } catch (exception) {
      // Handle exception here
    }
  }
}
