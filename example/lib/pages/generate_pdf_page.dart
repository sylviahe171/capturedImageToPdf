import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import '../image_pdf_api.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'to_tally_form_pdf_page.dart';
import 'pdf_viewer.dart';

import '../theme_constants.dart';

class GeneratePdfPage extends StatefulWidget {
  File generatedPdf;
  String websiteLink;

  GeneratePdfPage(this.websiteLink, {required this.generatedPdf, Key? key})
      : super(key: key);
  @override
  _GeneratePdfPageState createState() => _GeneratePdfPageState();
}

class _GeneratePdfPageState extends State<GeneratePdfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(children: [
          backgroundWidget(),
          Container(
              padding: EdgeInsets.all(20),
              child: Stack(children: [
                SingleChildScrollView(
                    child: Column(children: [
                  Text("注意事项",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                  SizedBox(height: 25),
                  Text(
                    "請嚴格遵照以下步驟上載答卷\n否則評語的質量有機會受到影響",
                    style: TextStyle(fontSize: 14, color: Color(0xFF9095A1)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),
                  Divider(),
                  SizedBox(height: 35),
                  Column(
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
                  SizedBox(height: 65),
                  Container(
                    height: MediaQuery.of(context).size.height *
                        0.6, // Adjust the height as needed
                    child: SfPdfViewer.file(widget.generatedPdf),
                  ),
                  // ElevatedButton(
                  //   onPressed: onPressed,
                  //   style: ButtonStyle(
                  //     minimumSize: MaterialStateProperty.all(
                  //         Size(350, 45)), // Set width and height of the button
                  //   ),
                  //   child: Text("重新掃描",
                  //       style:
                  //           TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
                  // ),
                  SizedBox(height: 90),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     imagePdf = await ImagePdfApi.generateImagePdf(
                  //         widget.generatedPictures);
                  //     setState() {
                  //       isFileGenerated = true;
                  //     }

                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) =>
                  //                 PdfViewerPage(widget.websiteLink, imagePdf)));
                  //   },
                  //   style: ButtonStyle(
                  //     minimumSize: MaterialStateProperty.all(
                  //         Size(350, 45)), // Set width and height of the button
                  //   ),
                  //   child: Text("生成PDF",
                  //       style:
                  //           TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
                  // )
                ])),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ToTallyFormPdfPage(
                                    widget.websiteLink, widget.generatedPdf)),
                          );
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(
                              200, 45)), // Set width and height of the button
                        ),
                        child: Text("下一步",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18)),
                      )),
                )
              ]))
        ]));
  }

  // void onPressed() async {
  //   List<String> picturesCollected;
  //   try {
  //     picturesCollected = await CunningDocumentScanner.getPictures() ?? [];
  //     if (!mounted) return;
  //     setState(() {
  //       widget.generatedPictures = picturesCollected;
  //     });

  //     // Navigate to AnotherPage after executing the above operations
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => GeneratePdfPage(widget.websiteLink,
  //               generatedPictures: widget.generatedPictures)),
  //     );
  //   } catch (exception) {
  //     // Handle exception here
  //   }
  // }
}
