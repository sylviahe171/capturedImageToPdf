import 'package:flutter/material.dart';
import 'web_pdf_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme_constants.dart';
import 'dart:io';
import 'qr_scanner_page.dart';

class ToTallyFormPdfPage extends StatelessWidget {
  final File filePdf;
  String websiteLink;
  ToTallyFormPdfPage(this.websiteLink, this.filePdf, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(children: [
          backgroundWidget(),
          Container(
              padding: const EdgeInsets.all(25),
              child: Column(children: [
                const SizedBox(height: 50),
                SvgPicture.asset('assets/icons/attribution-pen_thin.svg',
                    width: 100, height: 100, color: const Color(0xFF11ae8f)),
                const SizedBox(height: 10),
                const Text("手寫作文提交",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
                const SizedBox(height: 25),
                const Text("手寫作文的電子文檔已保存\n前往“作文提交”以自動上傳作文文檔",
                    style: TextStyle(fontSize: 14, color: Color(0xFF9095A1)),
                    textAlign: TextAlign.center),
                const SizedBox(height: 65),
                writingTypeCard("作文提交", "前往填表並以電子文檔形式提交手寫作文",
                    'assets/icons/form.svg', true, context),
                const SizedBox(height: 27),
                writingTypeCard("重新掃描作文二維碼", "爲了方便測試，暫時是去目錄",
                    'assets/icons/qr.svg', false, context),
              ]))
        ]));
  }

  GestureDetector writingTypeCard(String title, String description,
      String iconName, bool toTally, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (toTally) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewPdfContainer(
                      websiteLink,
                      pdf: filePdf,
                    )),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QRScannerPage()),
          );
        }
      },
      child: cardContentLayout(iconName, title, description),
    );
  }
}
