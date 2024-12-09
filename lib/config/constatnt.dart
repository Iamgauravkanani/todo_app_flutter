import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Constant {
  static Color white = Colors.white;
  static Color black = Colors.black;

  static TextStyle myStyle(
          {Color color = Colors.black,
          double fontsize = 16,
          FontWeight fontWeight = FontWeight.normal}) =>
      GoogleFonts.lato(
          fontSize: fontsize, color: color, fontWeight: fontWeight);
}

extension Extensions on num {
  Widget get height => SizedBox(height: toDouble());
  Widget get width => SizedBox(width: toDouble());
  EdgeInsets get symmetric =>
      EdgeInsets.symmetric(horizontal: toDouble(), vertical: toDouble());
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets get onlyLeft => EdgeInsets.only(left: toDouble());
  EdgeInsets get onlyRight => EdgeInsets.only(right: toDouble());
  EdgeInsets get onlyTop => EdgeInsets.only(top: toDouble());
  EdgeInsets get onlyBottom => EdgeInsets.only(bottom: toDouble());
  EdgeInsets get onlyLeftTop =>
      EdgeInsets.only(left: toDouble(), top: toDouble());
  double widthBox() => this * Get.width / 100;
  double heightBox() => this * Get.height / 100;
}
