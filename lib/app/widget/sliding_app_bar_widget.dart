/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-09-19 09:21:53
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-08 17:35:08
 */
import 'package:flutter/material.dart';

class SlidingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  SlidingAppBar({
    required this.child,
    required this.controller,
    required this.visible,
    this.height = kToolbarHeight,
  });

  final PreferredSizeWidget child;

  @override
  Size get preferredSize => Size.fromHeight(height);

  final AnimationController controller;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    visible ? controller.reverse() : controller.forward();
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: Offset(0, -1)).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }
}

class SlidingAppBar2 extends StatelessWidget {
  final double height;
  final Widget child;

  SlidingAppBar2({
    required this.child,
    required this.controller,
    required this.visible,
    this.height = kToolbarHeight,
  });

  final AnimationController controller;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    visible ? controller.reverse() : controller.forward();
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: Offset(0, -1)).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }
}
