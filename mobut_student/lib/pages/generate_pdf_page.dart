import 'dart:io';
import 'package:flutter/material.dart';
import 'web_pdf_page.dart';
import '../theme_constants.dart';

class GeneratePdfPage extends StatefulWidget {
  File generatedPdf;
  String websiteLink;
  List<String> picturesPath;

  GeneratePdfPage(this.websiteLink, this.picturesPath,
      {required this.generatedPdf, Key? key})
      : super(key: key);
  @override
  _GeneratePdfPageState createState() => _GeneratePdfPageState();
}

class _GeneratePdfPageState extends State<GeneratePdfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("掃描文檔預覽")),
        body: Stack(children: [
          backgroundWidget(),
          Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Column(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text("注意事项",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                const Text(
                  "1. 【極重要】裁去邊框以外的所有文字(包括學校名稱、學生名稱等一切非文章內容的資訊)，只留下邊框內的方格字",
                ),
                const SizedBox(height: 20),
                const Text(
                  "2.  小心檢查 PDF 是否已經包含作文的所有頁面",
                ),
                const SizedBox(height: 20),
                for (var picture in widget.picturesPath)
                  Image.file(File(picture)),
                const SizedBox(height: 65),
              ]),
              const SizedBox(height: 20),
            ])),
          ),
          Positioned(
            bottom: 40,
            left: 30,
            right: 30,
            child: Container(width: 200, child: nextStepButton(context)),
          )
        ]));
  }

  ElevatedButton nextStepButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewPdfContainer(
                    widget.websiteLink,
                    pdf: widget.generatedPdf,
                  )),
        );
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
            const Size(200, 45)), // Set width and height of the button
      ),
      child: const Text("下一步",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
    );
  }
}
