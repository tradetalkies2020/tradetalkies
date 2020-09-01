import 'package:flutter/material.dart';

ThemeData basicTheme() {
  // visualDensity: VisualDensity.adaptivePlatformDensity,
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.caption.copyWith(
        fontFamily: "Poppins",
        fontSize: 26.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headline2: base.caption.copyWith(
        fontFamily: "Poppins",
        fontSize: 20.0,
        color: Colors.black,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0
      ),
      headline3: base.caption.copyWith(
        fontSize: 14.0,
        fontFamily: 'Inter',
        color:Color(0xFF6D6D6D),

      ),
      headline4: base.caption.copyWith(
        fontSize: 16.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        color: Colors.white,
        // letterSpacing: 1.1,
      ),
      headline6: base.caption.copyWith(
        fontFamily: "",
        fontSize: 14.0,
        color: Colors.black.withOpacity(0.6),
        fontWeight: FontWeight.w400,
      ),
      bodyText1: base.bodyText1.copyWith(
        fontFamily: "",
        fontSize: 22.0,
        color: Colors.black,
      ),
      bodyText2: base.bodyText2.copyWith(
        fontFamily: "",
        fontSize: 22.0,
        color: Colors.black,
      ),
      caption: base.caption.copyWith(
        fontFamily: "",
        fontSize: 22.0,
        color: Colors.black,
      ),
      button: base.caption.copyWith(
        fontFamily: "",
        fontSize: 25.0,
        color: Colors.white,
      ),
    );
  }

  // Padding _basicPaddingTheme(Padding padding){
  //   return base.copyWith(
  //     p
  //   );
  // }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _basicTextTheme(base.textTheme),
    primaryColor: Colors.white,
    indicatorColor: Color(0xFF807A6B),
    scaffoldBackgroundColor: Colors.white,
    accentColor: Colors.blue,
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 20.0,
    ),
    buttonColor: Colors.blue,
    backgroundColor: Colors.white,
    tabBarTheme: base.tabBarTheme.copyWith(
      labelColor: Color(0xffce107c),
      unselectedLabelColor: Colors.grey,
    ),
  );
}
