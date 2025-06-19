import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Color(0xFF087E8b);
  static const Color primarySoft = Color(0xFF0E91A0);
  static const Color primaryExtraSoft = Color(0xFFEEF4F4);
  static const Color secondary = Color(0xFFF5F5F5);
  static const Color whiteSoft = Color(0xFFFDFDFD);
  static const Color ourPink = Color(0xFFc1839f);
  static LinearGradient bottomShadow = LinearGradient(colors: [Color(0xFF107873).withAlpha(20), Color(0xFF107873).withAlpha(0)], begin: Alignment.bottomCenter, end: Alignment.topCenter);
  static LinearGradient linearBlackBottom = LinearGradient(colors: [Colors.black.withAlpha(45), Colors.black.withAlpha(0)], begin: Alignment.bottomCenter, end: Alignment.topCenter);
  static LinearGradient linearBlackTop = LinearGradient(colors: [Colors.black.withAlpha(50), Colors.transparent], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}
