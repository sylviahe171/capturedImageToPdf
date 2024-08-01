import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme_constants.dart';
import 'scan_notice_page.dart';
import 'web_page.dart';
import 'qr_scanner_page.dart';

class WritingTypePage extends StatelessWidget {
  String websiteLink;
  WritingTypePage(this.websiteLink, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Custom navigation logic here
              // For example, navigate to a specific page instead of going back
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const QRScannerPage()));
            },
          ),
        ),
        body: Stack(children: [
          backgroundWidget(),
          Container(
              padding: const EdgeInsets.all(25),
              child: Column(children: [
                const SizedBox(height: 50),
                SvgPicture.asset('assets/icons/choose-alt.svg',
                    width: 100, height: 100, color: const Color(0xFF11ae8f)),
                const SizedBox(height: 10),
                const Text("文章類型",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
                const SizedBox(height: 25),
                const Text("选择适用的文章类型",
                    style: TextStyle(fontSize: 14, color: Color(0xFF9095A1))),
                const SizedBox(height: 65),
                writingTypeCard("手寫字", "轻松掃描写作原稿纸",
                    'assets/icons/attribution-pen.svg', true, context),
                const SizedBox(height: 27),
                writingTypeCard("電腦字", "输入或复制粘贴文章", 'assets/icons/computer.svg',
                    false, context),
              ]))
        ]));
  }

  GestureDetector writingTypeCard(String title, String description,
      String iconName, bool isHandWriting, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isHandWriting) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScanNoticePage(websiteLink)),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WebPage(websiteLink)),
          );
        }
      },
      child: cardContentLayout(iconName, title, description),
    );
  }
}
