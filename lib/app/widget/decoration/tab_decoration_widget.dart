import 'package:flutter/material.dart';

BoxDecoration buildBoxDecoration(
    double widthBorder, Color colorBorder, Color background) {
  return BoxDecoration(
      border: Border(
        top: BorderSide(width: widthBorder, color: colorBorder),
        left: BorderSide(width: widthBorder, color: colorBorder),
        right: BorderSide(width: widthBorder, color: colorBorder),
      ),
      color: background);
}
