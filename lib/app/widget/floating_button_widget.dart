import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FloatingButtonWidget extends StatelessWidget {
  final String textCenter;
  final String imgCenter;
  final String? imgRight;
  final Color? colorBackground;
  final Color? colorShadow;

  const FloatingButtonWidget({
    required this.textCenter,
    required this.imgCenter,
    this.imgRight,
    this.colorBackground,
    this.colorShadow,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 245,
      margin: EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      height: 35,
      decoration: BoxDecoration(
        color: ResourceColors.color_0f875c,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: ResourceColors.color_074d34,
            blurRadius: 0.5,
            offset: Offset(2, 4), // Shadow position
          ),
        ],
      ),
      child: Row(
        //Center Row contents vertically,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 20,
            ),
          ),
          Expanded(
            flex: 7,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  '$imgCenter',
                  height: 20.0,
                ),
                SizedBox(width: 7.0),
                Text(
                  '$textCenter',
                  style: TextStyle(
                    fontSize: DimenFont.sp12,
                    fontFamily: "NotoSansJPRegular",
                    color: ResourceColors.color_FFFFFF,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  Container(
                    child: this.imgRight != null
                        ? SvgPicture.asset(
                            '$imgRight',
                            height: 20.0,
                          )
                        : SizedBox(
                            width: 30,
                          ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
