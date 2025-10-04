

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  // TextStyles
  static TextStyle textStyleTitle = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.black, letterSpacing: 3)
  );
  static TextStyle textStyleSign = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.amber, letterSpacing: 3, fontSize: 30)
  );
  static TextStyle textStyleEndGame = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.amber[900], letterSpacing: 3, fontSize: 15)
  );

  // Colors
  static Color scaffoldBackgroundColor = Colors.grey[800]!;
  static Color appBarColor = Colors.amber;
  static Color gridBorderColor = Colors.grey;
  static Color dialogBackgroundColor = Colors.amber[200]!;

}