import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:flutter_my_page/app/utils/network/async_task.dart';

class DialogWidget extends StatefulWidget {
  String title;
  String content;
  VoidCallback? eventCallBack;
  bool hasCallBack;

  DialogWidget(
      {required this.title,
      required this.content,
      required this.hasCallBack,
      this.eventCallBack});

  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  TextStyle textStyle = TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
        title: Text(
          widget.title,
          style: textStyle,
        ),
        content: Text(
          widget.content,
          style: textStyle,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              widget.hasCallBack == true
                  ? handleCallBack()
                  : Navigator.of(context).pop();
            },
            child: Text(
              "Ok",
              style: TextStyle(
                color: ResourceColors.text_blue,
              ),
            ),
          )
        ],
      ),
    );
  }

  void handleCallBack() {
    Navigator.of(context).pop();
    widget.eventCallBack!();
  }
}
