import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_my_page/app/modules/home/models/item_notifi.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ExpandableNoti extends GetView<HomeController> {
  final ItemNotifi? itemNoti;
  final bool isReaded;

  ExpandableNoti(this.itemNoti, this.isReaded);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: controller.obx((state) => Container(
              height: 100.0, //Dimens.size100,
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: Dimens.size1, color: ResourceColors.lineColor),
                  ),
                  color: ResourceColors.color_FFFFFF),
              child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(
                          'assets/images/show_dialog_ic.svg',
                          height: 15.0, //Dimens.size15,
                          width: 15.0, //Dimens.size15,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 60.0),
                          child: Container(
                            child:
                                Text(removehtmlStr(itemNoti!.title!.toString()),
                                    style: new TextStyle(
                                      fontSize: DimenFont.sp15,
                                      fontWeight: isReaded == false
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      fontFamily: "NotoSansJPMedium",
                                    )),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child:
                            Text(parseDateTime(itemNoti!.fromDate!.toString()),
                                style: new TextStyle(
                                  fontSize: DimenFont.sp13,
                                  fontFamily: "NotoSansJPMedium",
                                )),
                      )
                    ],
                  )),
            )),
      ),
    );
  }
}

String removehtmlStr(String str) {
  String newStr;
  newStr = str.replaceAll(RegExp('<.*?>|<.*?/>'), '');

  return newStr;
}

String parseDateTime(String dateTime) {
  var parts = dateTime.split(' ');
  String date = parts[0].split('/')[0] +
      '年' +
      parts[0].split('/')[1] +
      '月' +
      parts[0].split('/')[2] +
      '日';
  return date;
}
