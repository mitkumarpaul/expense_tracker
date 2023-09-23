import 'package:flutter/material.dart';

const MaterialColor primaryMaterialColor = MaterialColor(
  4279567515,
  <int, Color>{
    50: Color.fromRGBO(
      21,
      4,
      155,
      .1,
    ),
    100: Color.fromRGBO(
      21,
      4,
      155,
      .2,
    ),
    200: Color.fromRGBO(
      21,
      4,
      155,
      .3,
    ),
    300: Color.fromRGBO(
      21,
      4,
      155,
      .4,
    ),
    400: Color.fromRGBO(
      21,
      4,
      155,
      .5,
    ),
    500: Color.fromRGBO(
      21,
      4,
      155,
      .6,
    ),
    600: Color.fromRGBO(
      21,
      4,
      155,
      .7,
    ),
    700: Color.fromRGBO(
      21,
      4,
      155,
      .8,
    ),
    800: Color.fromRGBO(
      21,
      4,
      155,
      .9,
    ),
    900: Color.fromRGBO(
      21,
      4,
      155,
      1,
    ),
  },
);

ThemeData myTheme = ThemeData(
  fontFamily: "customFont",
  primaryColor: const Color(0xff15049b),
  primarySwatch: primaryMaterialColor,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontFamily: "customFont",
      fontWeight: FontWeight.w600,
    ),
  ),
);
