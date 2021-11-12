import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/config/constants.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotiBadgerWidget extends StatefulWidget {
  int? numbersBadge;
  double? iconWidth;
  String imageStr;
  EdgeInsets? paddingBetweenIconBadge;
  Color? colorIcon;
  bool? isActive;



  NotiBadgerWidget({required this.numbersBadge, this.iconWidth,
    required this.imageStr, this.paddingBetweenIconBadge, this.colorIcon,
  this.isActive});

  @override
  _NotiBadgerWidgetState createState() => _NotiBadgerWidgetState();
}

class _NotiBadgerWidgetState extends State<NotiBadgerWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Padding(
          padding: widget.paddingBetweenIconBadge! == null ? EdgeInsets.only(top:2.0,right: 12.0):widget.paddingBetweenIconBadge!,
          child: SvgPicture.asset(
            widget.imageStr,
            height: widget.iconWidth == null ? kBottomNavNoticeIconSize:widget.iconWidth,
            color: widget.isActive == null ? (Colors.white):(widget.isActive == true?ResourceColors.myPageBackgroundColor:ResourceColors.iconGrayColor)
          ),
        ),
        Visibility(
          visible: widget.numbersBadge == 0?false:true,
          child: Container(
              width: 19.0, //19.0.dimension(),
              height: 19.0, //19.0.dimension(),
              decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              child: Padding(
                padding: EdgeInsets.all(0.0),
                child: Center(
                  child: Text(
                    widget.numbersBadge!.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0, //ScreenUtil.getInstance().getSp(12),
                    ),
                  ),
                ),
              )),
        )
      ],
    );
  }
}
