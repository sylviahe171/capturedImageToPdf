import 'package:flutter/material.dart';
import 'pages/qr_scanner_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'NotoSansTC',
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              color: Colors.white,
              titleTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF9CD396)),
                foregroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF264554))),
          )),
      home: const QRScannerPage(),
    );
  }
}
