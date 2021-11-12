/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-05-08 11:15:42
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-10 08:55:54
 */
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/modules/mine/controllers/change_language_controller.dart';
import 'package:flutter_my_page/app/utils/extensions/extension_dimens.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:get/get.dart';

class ChangeLanguagePage extends GetView<ChangeLanguageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('changeLanguagePage'.tr)),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                controller.selectedIndex.value = index;
                Locale locale;
                switch (index) {
                  case 0:
                    locale = Locale('en', 'US');
                    break;
                  case 1:
                    locale = Locale('ja', 'JP');
                    break;

                  default:
                    locale = Locale('en', 'US');
                    break;
                }
                controller.changeLanauage(locale);
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(
                    10.0.dimension(), Dimens.size10, Dimens.size10, 0),
                child: Obx(() => Container(
                      decoration: BoxDecoration(
                        border: controller.selectedIndex.value == index
                            ? Border.all(
                                color: Get.theme.primaryColor,
                                width: Dimens.size1)
                            : null,
                        color: ResourceColors.disabledBgColor,
                        borderRadius: BorderRadius.circular(Dimens.size10),
                      ),
                      padding: EdgeInsets.all(Dimens.size15),
                      child: Text(controller.titles[index]),
                    )),
              ),
            );
          },
          itemCount: controller.languages.length,
        ));
  }
}
