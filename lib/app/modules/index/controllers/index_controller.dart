/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-27 14:58:51
 * @LastEditors: saphir
 * @LastEditTime: 2021-06-02 17:29:12
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_my_page/app/common/firebase/firebase_message_helper.dart';
import 'package:flutter_my_page/app/modules/charge_detail/controllers/charge_detail_controller.dart';
import 'package:flutter_my_page/app/modules/charge_detail/views/charge_detail_view.dart';
import 'package:flutter_my_page/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_my_page/app/modules/home/views/home_page.dart';
import 'package:flutter_my_page/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_my_page/app/modules/profile/views/profile_view.dart';
import 'package:flutter_my_page/app/modules/transactions/controllers/transactions_controller.dart';
import 'package:flutter_my_page/app/modules/transactions/views/transactions_view.dart';
import 'package:flutter_my_page/app/utils/keep_alive_page.dart';
import 'package:get/get.dart';

class IndexController extends GetxController {
  RxString title = 'NOTICE_TITLE'.tr.obs;
  RxInt notiCount = FirebaseMessageHelper().getTotalNotificationFireBase().obs;
  DateTime? lastTime;
  RxInt tabIndex = 0.obs;
  PageController? pageController;
  RxBool isShowBottomBar = true.obs;
  RxBool isShowNotiMenu = FirebaseMessageHelper().hasNotificationFireBase().obs;
  RxInt countNofiFireBase = FirebaseMessageHelper().getTotalNotificationFireBase().obs;

  final List<Widget> pages = [
    keepAliveWrapper(GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return HomePage();
        })),
    keepAliveWrapper(GetBuilder<TransactionsController>(
        init: TransactionsController(),
        builder: (controller) {
          return TransactionsPage();
        })),
    keepAliveWrapper(GetBuilder<ChargeDetailController>(
        init: ChargeDetailController(),
        builder: (controller) {
          return ChargeDetailPage();
        })),
    keepAliveWrapper(GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return ProfilePage();
        })),
  ];
  @override
  void onReady() {
    print("onReady");
    super.onReady();
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: tabIndex.value);
    super.onInit();
  }
}
