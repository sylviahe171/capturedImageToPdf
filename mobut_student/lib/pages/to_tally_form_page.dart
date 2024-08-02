import 'package:flutter/material.dart';
import 'web_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme_constants.dart';
import 'qr_scanner_page.dart';

class ToTallyFormPage extends StatelessWidget {
  String websiteLink;
  ToTallyFormPage(this.websiteLink, {Key? key}) : super(key: key);

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
                SvgPicture.asset('assets/icons/computer_thin.svg',
                    width: 100, height: 100, color: const Color(0xFF11ad8f)),
                const SizedBox(height: 10),
                const Text("電腦作文提交",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
                const SizedBox(height: 25),
                const Text("前往提交作文",
                    style: TextStyle(fontSize: 14, color: Color(0xFF9095A1))),
                const SizedBox(height: 45),
                writingTypeCard("作文提交", "前往填寫表格並複製粘貼作文",
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
            MaterialPageRoute(builder: (context) => WebPage(websiteLink)),
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
