import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';

class InfoButtton extends StatelessWidget {
  final String url;
  final String label;
  final double labelSize;
  final Function onPressed;
  final bool right;
  const InfoButtton(
      {Key? key,
      required this.right,
      required this.labelSize,
      required this.url,
      required this.label,
      required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return buildInfoButton(url, right, labelSize, label, onPressed);
  }
}

Widget buildInfoButton(String url, bool right, double labelSize, String label,
    Function onPressed) {
  return Container(
    height: 40.0,
    child: TextButton.icon(
      style: TextButton.styleFrom(
        textStyle: TextStyle(
          color: const Color(0xFFeeeeee),
        ),
        backgroundColor: ResourceColors.color_eeeeee,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: right ? Radius.circular(5.0) : Radius.circular(0.0),
            bottomRight: right ? Radius.circular(5.0) : Radius.circular(0.0),
            topLeft: right ? Radius.circular(0.0) : Radius.circular(5.0),
            bottomLeft: right ? Radius.circular(0.0) : Radius.circular(5.0),
          ),
        ),
      ),
      onPressed: onPressed as void Function()?,
      icon: Padding(
        padding: EdgeInsets.only(bottom: 1.0),
        child: SvgPicture.asset(
          "$url",
          height: labelSize,
        ),
      ),
      label: Text(
        "$label",
        style: TextStyle(
          fontSize: DimenFont.sp12,
          color: ResourceColors.color_0e67ed,
          fontFamily: "NotoSansJPBold",
        ),
      ),
    ),
  );
}
