/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-27 15:03:30
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-08 16:13:39
 */
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/common/helper_function.dart';
import 'package:flutter_my_page/app/config/constants.dart';
import 'package:flutter_my_page/app/modules/index/controllers/index_controller.dart';
import 'package:flutter_my_page/app/modules/login/models/login_customcss.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/utils/extensions/extension_dimens.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:flutter_my_page/app/utils/log/log.dart';
import 'package:flutter_my_page/app/utils/toast/toast.dart';
import 'package:flutter_my_page/app/widget/mypage_drawer.dart';
import 'package:flutter_my_page/app/widget/notiBadger_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class IndexPage extends GetView<IndexController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Container(
          color: ResourceColors.myPageBackgroundColor,
          child: Scaffold(
            key: _scaffoldKey,
            // 1. AppBar
            appBar: _buidAppBar(),
            // 2. Drawer
            endDrawer: _buildDrawer(context),
            // 3. Bottom bar
            bottomNavigationBar: _buildBottomNavigationBar(),
            // 4. Body
            body: _buildBody(),
          ),
        ),
        onWillPop: _isExit);
  }

  PreferredSizeWidget _buidAppBar() {
    return AppBar(
      backgroundColor: ResourceColors.myPageBackgroundColor,
      // Left - Icon
      leading: Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: SvgPicture.asset(
          'assets/images/login_logo.svg',
          height: 36.0, //Dimens.size36,
          width: 74.0, //Dimens.size74,
        ),
      ),
      leadingWidth: 74.0,
      // Middle - Title
      title: Obx(
        () => Center(
          child: Text(
            controller.title.value,
            style: TextStyle(
              fontFamily: "NotoSansJPBlack",
              fontSize: 20.0, //ScreenUtil.getInstance().getSp(20),
              color: Colors.white,
            ),
          ),
        ),
      ),
      // Right - Menu
      // Right - Menu
      actions: <Widget>[
        InkWell(
          onTap: () {
            print("Open top menu");
            _scaffoldKey.currentState!.openEndDrawer();
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              _buildIconMenu(),
              _buildNotiIconOfMenu(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconMenu() {
    return Container(
      padding: EdgeInsets.only(top: 5.0, right: 8.0),
      child: SvgPicture.asset(
        'assets/images/menu_ic.svg',
        height: 42.0, //Dimens.size48,
        width: 42.0, //Dimens.size48,
      ),
    );
  }

  Obx _buildNotiIconOfMenu() {
    return Obx(
      () => Visibility(
        visible: controller.isShowNotiMenu.value,
        child: Container(
          child: SvgPicture.asset(
            'assets/images/noti_menu_ic.svg',
            height: 22.0, //Dimens.size48,
            width: 22.0, //Dimens.size48,
          ),
        ),
      ),
    );
  }

  Theme _buildDrawer(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: ScreenUtil.getInstance().statusBarHeight),
        child: Obx(
          () => MyPageDrawer(
            countNotiFireBase: controller.countNofiFireBase.value,
            onTap: (index) {
              // Hamburger menu event
              Navigator.of(context).pop();
              switch (index) {
                case 8:
                  HelperFunction.launcASOPApp();
                  break;
                case 9:
                  HelperFunction.launchURL();
                  break;
                default:
                  if (controller.tabIndex.value != index) {
                    controller.tabIndex.value = index;
                    controller.title.value = BOTTOM_TITLE_LIST[index];
                    controller.pageController?.jumpToPage(index);
                  }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: controller.isShowBottomBar.value == true
            ? (70.0 + ScreenUtil.getInstance().bottomBarHeight)
            : 0,
        child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(width: 0.5, color: Colors.grey))),
              child: Obx(() => BottomNavigationBar(
                    backgroundColor: Colors.white,
                    items: [
                      BottomNavigationBarItem(
                        label: 'NOTICE_TITLE'.tr,
                        icon: badgerTitle(false),
                        activeIcon: badgerTitle(true),
                      ),
                      BottomNavigationBarItem(
                        label: 'TRANSACTIONS'.tr,
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: badgerTransactions(false),
                        ),
                        activeIcon: Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: badgerTransactions(true),
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: 'CHARGE_DETAIL'.tr,
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: badgerChargeDetail(false),
                        ),
                        activeIcon: Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: badgerChargeDetail(true),
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: 'PROFILE'.tr,
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: badgerProfile(false),
                        ),
                        activeIcon: Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: badgerProfile(true),
                        ),
                      ),
                    ],
                    type: BottomNavigationBarType.fixed,
                    currentIndex: controller.tabIndex.value,
                    elevation: 0,
                    iconSize: Dimens.size24,
                    selectedFontSize: DimenFont.normal,
                    selectedLabelStyle: ASV_LabelStyle1,
                    unselectedFontSize: DimenFont.normal,
                    unselectedLabelStyle: ASV_LabelStyle1,
                    selectedItemColor: ResourceColors.myPageBackgroundColor,
                    unselectedItemColor: ResourceColors.color_949494,
                    onTap: (index) {
                      controller.tabIndex.value = index;
                      controller.title.value = BOTTOM_TITLE_LIST[index];
                      controller.pageController?.jumpToPage(index);
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget badgerTitle(bool isActive) {
    return NotiBadgerWidget(
        numbersBadge: controller.notiCount.value,
        imageStr: 'assets/images/notice_ic.svg',
        paddingBetweenIconBadge: EdgeInsets.only(right: 8.0),
        isActive: isActive);
  }

  Widget badgerTransactions(bool isActive) {
    return NotiBadgerWidget(
        numbersBadge: BADGE_DEFAULT,
        imageStr: 'assets/images/transactions_ic.svg',
        paddingBetweenIconBadge: EdgeInsets.only(left: 0.0),
        isActive: isActive);
  }

  Widget badgerChargeDetail(bool isActive) {
    return NotiBadgerWidget(
        numbersBadge: BADGE_DEFAULT,
        imageStr: 'assets/images/charge_detail_ic.svg',
        paddingBetweenIconBadge: EdgeInsets.only(right: 0.0),
        iconWidth: kBottomNavIconSize,
        isActive: isActive);
  }

  Widget badgerProfile(bool isActive) {
    return NotiBadgerWidget(
        numbersBadge: BADGE_DEFAULT,
        imageStr: 'assets/images/profile_ic.svg',
        paddingBetweenIconBadge: EdgeInsets.only(right: 0.0),
        isActive: isActive);
  }

  PageView _buildBody() {
    return PageView(
      controller: controller.pageController,
      children: controller.pages,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  Future<bool> _isExit() async {
    if (controller.lastTime == null ||
        DateTime.now().difference(controller.lastTime!) >
            Duration(milliseconds: 1500)) {
      controller.lastTime = DateTime.now();
      Toast.show("もう一度タップしてアプリを終了します");
      return false;
    }
    Toast.cancelToast();
    return true;
  }
}
