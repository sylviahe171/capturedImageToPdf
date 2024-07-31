import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'home_page.dart';
import '../pop_up_card.dart';
import '../theme_constants.dart';
import 'dart:async';
import 'writing_type_page.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage>
    with WidgetsBindingObserver {
  bool _screenOpened = false;
  MobileScannerController cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal, returnImage: true);

  StreamSubscription<Object>? _subscription;
  Barcode? _barcode;

  @override
  void initState() {
    super.initState();
    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);

    // Start listening to the barcode events.
    _subscription = cameraController.barcodes.listen(_handleBarcode);

    // Finally, start the scanner itself.
    unawaited(cameraController.start());
  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;
    // Dispose the widget itself.
    super.dispose();
    // Finally, dispose of the controller.
    await cameraController.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!cameraController.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.resumed:
        // Restart the scanner when the app is resumed.
        // Don't forget to resume listening to the barcode events.
        _subscription = cameraController.barcodes.listen(_handleBarcode);

        unawaited(cameraController.start());
        return;

      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(cameraController.stop());
    }
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("QR Scanner"), leading: Container()),
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
      _screenOpened = true;
      String code = barcodes[0].rawValue ?? "___";

      // Navigate to a new page
      //the result have to contains wechat in it. this is for testing purpose
      /*if (code.contains("wechat.com")) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopUpCard(true, code);
            }).then((_) {
          _screenOpened = false;
        });
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return PopUpCard(false, code);
            }).then((_) {
          _screenOpened = false;
        });
      }
      */

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WritingTypePage()),
      );
    }
  }
}
