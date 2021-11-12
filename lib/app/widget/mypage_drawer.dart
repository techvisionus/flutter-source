/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-09-19 09:21:53
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-08 17:35:08
 */

import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/config/constants.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:flutter_my_page/app/widget/notiBadger_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';

class MyPageDrawer extends StatelessWidget {
  var titleList = [
    "NOTICE_TITLE".tr,
    "TRANSACTIONS".tr,
    "CHARGE_DETAIL".tr,
    "PROFILE".tr,
    "TERMSOFSERVICE".tr,
    "PRIVACYPOLICY".tr,
    "INQUIRY".tr,
    "APPINFORMATION".tr
  ];

  final Function(int) onTap;

  final countNotiFireBase;

  MyPageDrawer({required this.onTap, this.countNotiFireBase});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Row(children: <Widget>[
        GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 47.0,
              child: Column(children: <Widget>[
                Container(
                  width: double.infinity,
                  color: ResourceColors.drawer_bg,
                  child: Column(children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 5),
                        child: SvgPicture.asset(
                          'assets/images/close_drawer.svg',
                          height: Dimens.size18,
                          color: ResourceColors.color_white,
                        )),
                    Text("MENU",
                        style: TextStyle(
                            color: ResourceColors.color_white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400))
                  ]),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ]),
            )),
        Expanded(
          child: Container(
            color: ResourceColors.drawer_bg,
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                _buildNotice(),
                _buildTransactions(),
                _buildChargedetail(),
                _buildProfileic(),
                _buildTermsofservice(),
                _buildPrivacypolicy(),
                _buildInquiry(),
                //
                _buildAppinformation(),
                //
                _buildOpenASOPApp(),
                _buildOpenASNET(),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget _buildNotice() {
    return Container(
        child: ListTile(
          onTap: () {
            onTap(0);
          },
          leading: NotiBadgerWidget(
            numbersBadge: countNotiFireBase,
            imageStr: 'assets/images/notice_ic.svg',
            paddingBetweenIconBadge: EdgeInsets.only(top: 2.0, right: 12.0),
            iconWidth: kDrawNoticeIconWidth,
          ),
          title: Text(
            "NOTICE_TITLE".tr,
            style: TextStyle(
                color: ResourceColors.color_white,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            color: ResourceColors.color_white,
            size: 16,
          ),
        ),
        decoration: new BoxDecoration(
            border: new Border(
                bottom: new BorderSide(color: ResourceColors.drawer_border))));
  }

  Widget _buildTransactions() {
    return Container(
        child: ListTile(
          onTap: () {
            onTap(1);
          },
          leading: NotiBadgerWidget(
            numbersBadge: BADGE_DEFAULT,
            imageStr: 'assets/images/transactions_ic.svg',
            paddingBetweenIconBadge: EdgeInsets.only(top: 2.0, right: 12.0),
            iconWidth: kDrawIconWidth,
          ),
          title: Text(
            "TRANSACTIONS".tr,
            style: TextStyle(
                color: ResourceColors.color_white,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            color: ResourceColors.color_white,
            size: 16,
          ),
        ),
        decoration: new BoxDecoration(
            border: new Border(
                bottom: new BorderSide(color: ResourceColors.drawer_border))));
  }

  Widget _buildChargedetail() {
    return Container(
        child: ListTile(
          onTap: () {
            onTap(2);
          },
          leading: Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2.0, right: 12.0),
                  child: SvgPicture.asset(
                    'assets/images/charge_detail_ic.svg',
                    height: kDrawNoticeIconWidth,
                    color: ResourceColors.color_white,
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            "CHARGE_DETAIL".tr,
            style: TextStyle(
                color: ResourceColors.color_white,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            color: ResourceColors.color_white,
            size: 16,
          ),
        ),
        decoration: new BoxDecoration(
            border: new Border(
                bottom: new BorderSide(color: ResourceColors.drawer_border))));
  }

  Widget _buildProfileic() {
    return Container(
        child: ListTile(
          onTap: () {
            onTap(3);
          },
          leading: Padding(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                SvgPicture.asset(
                  'assets/images/profile_ic.svg',
                  width: kDrawIconWidth,
                  color: ResourceColors.color_white,
                ),
              ],
            ),
          ),
          title: Text(
            "PROFILE".tr,
            style: TextStyle(
                color: ResourceColors.color_white,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            color: ResourceColors.color_white,
            size: 16,
          ),
        ),
        decoration: new BoxDecoration(
            border: new Border(
                bottom: new BorderSide(color: ResourceColors.drawer_border))));
  }

  Widget _buildTermsofservice() {
    return Column(
      children: [
        Container(
          child: ListTile(
            onTap: () {
              onTap(4);
            },
            leading: Padding(
              padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  SvgPicture.asset(
                    'assets/images/term_of_service_ic.svg',
                    height: kDrawIconWidth,
                    width: kDrawIconWidth,
                    color: ResourceColors.color_white,
                  ),
                ],
              ),
            ),
            title: Text(
              "TERMSOFSERVICE".tr,
              style: TextStyle(
                  color: ResourceColors.color_white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: ResourceColors.color_white,
              size: 16,
            ),
          ),
          // decoration: new BoxDecoration(
          //   border: new Border(
          //     bottom: new BorderSide(color: ResourceColors.drawer_border),
          //   ),
          // ),
        ),
        SizedBox(
          height: 0.0,
          child: Divider(
            thickness: 1.0,
            indent: 50.0,
            color: ResourceColors.drawer_border,
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacypolicy() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 50.0),
          child: ListTile(
            title: Text(
              "PRIVACYPOLICY".tr,
              style: TextStyle(
                  color: ResourceColors.color_white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: ResourceColors.color_white,
              size: 16,
            ),
          ),
          // decoration: new BoxDecoration(
          //   border: new Border(
          //       bottom: new BorderSide(color: ResourceColors.drawer_border)),
          // ),
        ),
        SizedBox(
          height: 0.0,
          child: Divider(
            thickness: 1.0,
            indent: 50.0,
            color: ResourceColors.drawer_border,
          ),
        ),
      ],
    );
  }

  Widget _buildInquiry() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 50.0),
          child: ListTile(
            title: Text(
              "INQUIRY".tr,
              style: TextStyle(
                  color: ResourceColors.color_white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: ResourceColors.color_white,
              size: 16,
            ),
          ),
          // decoration: new BoxDecoration(
          //   border: new Border(
          //       bottom: new BorderSide(color: ResourceColors.drawer_border)),
          // ),
        ),
        SizedBox(
          height: 0.0,
          child: Divider(
            thickness: 1.0,
            indent: 50.0,
            color: ResourceColors.drawer_border,
          ),
        ),
      ],
    );
  }

  Widget _buildAppinformation() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 50.0),
          child: ListTile(
            title: Text(
              "APPINFORMATION".tr,
              style: TextStyle(
                  color: ResourceColors.color_white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: ResourceColors.color_white,
              size: 16,
            ),
          ),
          decoration: new BoxDecoration(
            border: new Border(
                bottom: new BorderSide(color: ResourceColors.drawer_border)),
          ),
        ),
      ],
    );
  }

  Widget _buildOpenASOPApp() {
    return Container(
        child: ListTile(
          onTap: () {
            onTap(8);
          },
          leading: Padding(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                SvgPicture.asset(
                  'assets/images/asop_draw_ic.svg',
                  height: kDrawIconWidth,
                  width: kDrawIconWidth,
                  color: ResourceColors.color_white,
                ),
              ],
            ),
          ),
          title: Text(
            "ASOP_APP_NAME".tr,
            style: TextStyle(
                color: ResourceColors.color_white,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            color: ResourceColors.color_white,
            size: 16,
          ),
        ),
        decoration: new BoxDecoration(
            border: new Border(
                bottom: new BorderSide(color: ResourceColors.drawer_border),
                top: new BorderSide(color: ResourceColors.drawer_border))));
  }

  Widget _buildOpenASNET() {
    return Container(
        child: ListTile(
          onTap: () {
            onTap(9);
          },
          leading: Padding(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                SvgPicture.asset(
                  'assets/images/login_logo.svg',
                  width: kDrawNoticeIconWidth,
                  color: ResourceColors.color_white,
                ),
              ],
            ),
          ),
          title: Text(
            "ASNET_TEXT".tr,
            style: TextStyle(
                color: ResourceColors.color_white,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            color: ResourceColors.color_white,
            size: 16,
          ),
        ),
        decoration: new BoxDecoration(
            border: new Border(
                bottom: new BorderSide(color: ResourceColors.drawer_border),
                top: new BorderSide(color: ResourceColors.drawer_border))));
  }
}
