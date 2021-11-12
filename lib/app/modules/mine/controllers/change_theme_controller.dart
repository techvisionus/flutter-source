/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-05-08 09:25:35
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-08 14:04:55
 */
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/plugins/options/themes.dart';
import 'package:flutter_my_page/app/utils/sp_utils/sp_utils.dart';
import 'package:get/get.dart';

class ChangeThemeController extends GetxController {
  List<AppTheme> themeList = [lightTheme, darkTheme, customTheme];
  int selectedIndex = 0;

  @override
  void onInit() {
    super.onInit();
    String themeName = SpUtils.get<String>('theme');
    int index = themeList.indexWhere((element) => element.name == themeName);
    selectedIndex = (index == -1 ? 0 : index);
  }

  void changeTheme(int index, String theme) {
    selectedIndex = index;
    Get.changeTheme(themeList[index].data);
    SpUtils.put('theme', themeList[index].name);
  }
}
