import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

abstract class AppConst {
  static Color primary = HexColor('#eb008b');
  static Gradient primaryGradient = LinearGradient(
    colors: [HexColor('#000000'), HexColor('#eb008b')],
    begin: Alignment.bottomCenter,
    end: Alignment.topRight,
  );
  static Color red = Colors.red;
  static Color white = HexColor('#ffffff');
  static Color black = HexColor('#000000');
  static Color grey = Colors.grey;
  static Color grey400 = Colors.grey.shade400;
  static Color gold = HexColor('#ecb337');
  static Color brown = HexColor('#452612');
  static Color whiteOpacity = Colors.white.withOpacity(0.8);
  static Color blackOpacity = Color.fromARGB(154, 0, 0, 0);
  static Color transparent = Colors.transparent;
  static Color brightWhite = HexColor('#2eb2be');
}
