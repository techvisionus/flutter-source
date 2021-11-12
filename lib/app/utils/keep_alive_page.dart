/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-25 10:58:43
 * @LastEditors: saphir
 * @LastEditTime: 2021-04-27 15:15:29
 */
import 'package:flutter/material.dart';

//Page keep alive method
Widget keepAliveWrapper(Widget child) => _KeepAliveWidget(child);

class _KeepAliveWidget extends StatefulWidget {
  final Widget child;
  const _KeepAliveWidget(this.child);

  @override
  State<StatefulWidget> createState() {
    return _KeepAliveState();
  }
}

class _KeepAliveState extends State<_KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
