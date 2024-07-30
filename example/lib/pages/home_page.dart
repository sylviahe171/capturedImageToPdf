import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:pdf/widgets.dart' as pw;
import '../image_pdf_api.dart';
import 'web_page.dart';
import 'qr_scanner_page.dart';
import '../pop_up_card.dart';
import 'writing_type_page.dart';

//check why cannot navigate material app!!!!!!!!!
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  List<String> _pictures = [];
  late final File imagePdf;

  final pdf = pw.Document();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ElevatedButton(onPressed: onPressed, child: const Text("1. 拍文章照片")),
          for (var picture in _pictures) Image.file(File(picture)),
          for (var picture in _pictures) Text(picture),
          ElevatedButton(
              onPressed: () async {
                imagePdf = await ImagePdfApi.generateImagePdf(_pictures);
              },
              child: const Text("2.生成pdf")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewContainer(
                            pdf: imagePdf,
                          )),
                );
              },
              child: const Text("3. 閲讀生成的pdf")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRScannerPage()),
                );
              },
              child: const Text("掃二維碼")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PopUpCard(true)),
                );
              },
              child: const Text("彈窗成功")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PopUpCard(false)),
                );
              },
              child: const Text("彈窗失敗")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WritingTypePage()),
                );
              },
              child: const Text("文章選擇")),
        ]),
      ),
    );
  }

  void onPressed() async {
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
      if (!mounted) return;
      setState(() {
        _pictures = pictures;
      });
    } catch (exception) {
      // Handle exception here
    }
  }
}
