import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/widget/dialog/dialog_widget.dart';

Future buildDialog({
  required BuildContext context,
  required String title,
  required String content,
  required bool hasCallBack,
  required VoidCallback eventCallBack

}) {
  DialogWidget dialogWidget = DialogWidget(title: title, content: content,hasCallBack: hasCallBack, eventCallBack: eventCallBack);
  return showDialog(
      context: context,
      builder: (BuildContext context){
        return dialogWidget;
      });

}

enum EPopupType {
  WARNING,
  INFORMATION,
  ERROR,
  QUESTION,
}