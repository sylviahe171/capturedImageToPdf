import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

Color grassGreen = Color(0xFF5F9F6D);
Color lightRed = Color(0xFFE79473);

ThemeData theme = ThemeData(
    fontFamily: 'NotoSansTC',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF000000))),
    ));

Container backgroundWidget() {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/icons/background.png'),
        fit: BoxFit.cover, // Cover the whole container
        alignment: Alignment.bottomCenter, // Center the image
      ),
    ),
  );
}

BoxDecoration cardDesign() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      const BoxShadow(
        color: Color(0x22171a1f),
        blurRadius: 12,
        offset: Offset(0, 4), // Shadow position
      ),
    ],
  );
}

Container cardContentLayout(String iconName, String title, String description) {
  return Container(
    width: 330,
    height: 110,
    padding: const EdgeInsets.only(left: 40, right: 20, top: 25, bottom: 25),
    decoration: cardDesign(),
    child: Row(children: [
      SvgPicture.asset(iconName, width: 80, height: 50, color: grassGreen),
      const SizedBox(width: 20),
      Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Ensure text starts from the left
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF245130))),
          const SizedBox(height: 10),
          Text(description,
              style: const TextStyle(fontSize: 14, color: Color(0xFF9095A1)))
        ],
      ),
    ]),
  );
}
