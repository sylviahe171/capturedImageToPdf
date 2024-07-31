import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'home_page.dart';
import '../pop_up_card.dart';
import '../theme_constants.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool _screenOpened = false;
  MobileScannerController cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal, returnImage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("QR Scanner")),
        backgroundColor: Colors.green.withOpacity(0.1),
        body: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(children: [
              Expanded(
                  child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                    Text("將作文二維碼置於框中",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1)),
                  ]))),
              Expanded(
                flex: 4,
                child: MobileScanner(
                  controller: cameraController,
                  onDetect: _foundBarcode,
                ),
              ),
              Expanded(child: Container()),
            ])));
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }

  void _foundBarcode(BarcodeCapture capture) {
    if (!_screenOpened) {
      final List<Barcode> barcodes = capture.barcodes;

      for (final barcode in barcodes) {
        String code = barcode.rawValue ?? "___";

        // Navigate to a new page
        //the result have to contains wechat in it. this is for testing purpose
        if (code.contains("wechat.com")) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return PopUpCard(true, code);
              });
        } else {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return PopUpCard(false, code);
              });
        }

        _screenOpened = true;
      }
    }
  }
}
