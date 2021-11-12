import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';

class BuildTextBackground extends StatelessWidget {
  double? width;
  double? height;
  Color? colorBackground;
  Color? colorBorder;
  double? radiusBackground;
  String? titleName;
  Color? textColor;
  EdgeInsets? padding;

  BuildTextBackground(
      {this.width,
      this.height,
      this.colorBackground,
      this.colorBorder,
      this.radiusBackground,
      required this.titleName,
      this.textColor,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding != null ? padding! : EdgeInsets.only(top: 0.0),
      child: Container(
          width: width != null ? width : Dimens.size90,
          height: height != null ? height : Dimens.size25,
          decoration: BoxDecoration(
              color: colorBackground != null
                  ? colorBackground
                  : Colors.transparent,
              border: Border.all(
                  color:
                      colorBorder != null ? colorBorder! : Colors.transparent,
                  style: BorderStyle.solid,
                  width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(
                  radiusBackground != null ? radiusBackground! : 5))),
          child: Center(
            child: Text(titleName!,
                style: TextStyle(
                  fontSize: DimenFont.middle,
                  color: textColor != null ? textColor! : Color(0xFF289f74),
                )),
          )),
    );
  }
}
