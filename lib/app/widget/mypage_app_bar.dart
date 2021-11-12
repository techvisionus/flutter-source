/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-09-19 09:21:53
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-08 17:35:08
 */

/* HOW TO USE IN THIS PROJECT
PreferredSizeWidget _buidAppBar() {
    return MyPageAppBar(
      title: Obx(
        () => Text(
          controller.title.value,
          style: TextStyle(
            fontFamily: "NotoSansJPBlack",
            fontSize: 20.0, //ScreenUtil.getInstance().getSp(20),
            color: Colors.white,
          ),
        ),
      ),
      height: 70.0, //70.0.dimension(),
      onTap: () {
        print("Open top menu");
        _scaffoldKey.currentState!.openEndDrawer();
      },
    );
  }
*/

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/config/constants.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/utils/extensions/extension_dimens.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final double height;
  final VoidCallback? onTap;

  MyPageAppBar({
    required this.title,
    this.height = kToolbarHeight,
    this.onTap,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: ResourceColors.myPageBackgroundColor,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: SvgPicture.asset(
                'assets/images/app_bar_logo.svg',
                height: 36.0, //Dimens.size36,
                width: 74.0, //Dimens.size74,
              ),
            ),
          ),
          Align(alignment: Alignment.center, child: title),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: InkWell(
                onTap: onTap,
                child: SvgPicture.asset(
                  'assets/images/menu_ic.svg',
                  height: 48.0, //Dimens.size48,
                  width: 48.0, //Dimens.size48,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
