import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'theme_constants.dart';

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
          primaryColor: Colors.white,
          fontFamily: 'NotoSansTC',
          appBarTheme: AppBarTheme(
            color: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFC8E6B8)),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF396222))),
          )),
      home: HomePage(),
    );
  }
}
