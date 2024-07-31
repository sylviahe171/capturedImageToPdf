import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:pdf/widgets.dart' as pw;
import '../image_pdf_api.dart';
import 'generate_pdf_page.dart';

class ScanNoticePage extends StatefulWidget {
  @override
  State<ScanNoticePage> createState() => _ScanNoticePageState();
}

class _ScanNoticePageState extends State<ScanNoticePage> {
  List<String> scannedPictures = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("手寫字作文提交")),
        body: Container(
            padding: EdgeInsets.all(40),
            child: Column(children: [
              Text("注意事项",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              SizedBox(height: 25),
              Text(
                "請嚴格遵照以下步驟上載答卷\n否則評語的質量有機會受到影響",
                style: TextStyle(fontSize: 14, color: Color(0xFF9095A1)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              Divider(),
              SizedBox(height: 35),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              SizedBox(height: 65),
              ElevatedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      Size(350, 45)), // Set width and height of the button
                ),
                child: Text("開始掃描",
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
              )
            ])));
  }

  void onPressed() async {
    List<String> picturesCollected;
    try {
      picturesCollected = await CunningDocumentScanner.getPictures() ?? [];
      if (!mounted) return;
      setState(() {
        scannedPictures = picturesCollected;
      });

      // Navigate to AnotherPage after executing the above operations
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                GeneratePdfPage(generatedPictures: scannedPictures)),
      );
    } catch (exception) {
      // Handle exception here
    }
  }
}
