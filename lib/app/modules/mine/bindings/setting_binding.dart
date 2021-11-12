/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-05-08 15:50:24
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-08 15:50:59
 */
import 'package:flutter_my_page/app/modules/mine/controllers/setting_controller.dart';
import 'package:get/get.dart';

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
