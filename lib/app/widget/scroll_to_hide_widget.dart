/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-09-19 09:21:53
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-08 17:35:08
 */

import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_my_page/app/utils/extensions/extension_dimens.dart';

class ScrollToHideWidget extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;

  const ScrollToHideWidget({
    Key? key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  _ScrollToHideWidgetState createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);

    super.dispose();
  }

  void listen() {
    final direction = widget.controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisible) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: widget.duration,
        height: isVisible
            ? (70.0.dimension() + ScreenUtil.getInstance().bottomBarHeight)
            : 0,
        child: Wrap(
          children: [widget.child],
        ),
      );
}
