import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:flutter_my_page/app/widget/dialog/dialog_widget.dart';
import 'package:get/get.dart';

class MyPageDialog {
  static void showDialog(String title, String content, bool hasCallBack,
      {VoidCallback? eventCallBack}) {
    Get.dialog(DialogWidget(
      title: title,
      content: content,
      hasCallBack: hasCallBack,
      eventCallBack: eventCallBack != null ? eventCallBack : null,
    ));
  }
}
