import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:get/get.dart';

class CreateTabBar extends StatefulWidget {
  TabController? tabController;
  final List<Widget>? tabs;
  RxBool isShowTabBar;
  VoidCallback? eventCallBack;

  CreateTabBar(
      {@required this.tabController,
      required this.isShowTabBar,
      @required this.tabs,
      this.eventCallBack});

  @override
  _CreateTabBarState createState() => _CreateTabBarState();
}

class _CreateTabBarState extends State<CreateTabBar> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: ResourceColors.color_d5,
      duration: const Duration(milliseconds: 300),
      height: widget.isShowTabBar.value ? 55.0 : 0,
      child: Wrap(
        children: [
          Visibility(
            visible: widget.isShowTabBar.value,
            child: createTabBar(),
          )
        ],
      ),
    );
  }

  Widget createTabBar() {
    return Container(
      padding:
          EdgeInsets.only(top: 6.0, right: Dimens.size5, left: Dimens.size5),
      child: TabBar(
        controller: widget.tabController,
        tabs: widget.tabs!,
        labelColor: ResourceColors.text_black,
        unselectedLabelColor: ResourceColors.color_4674ec,
        indicatorColor: ResourceColors.color_white,
        indicatorWeight: 1,
        labelPadding: EdgeInsets.symmetric(horizontal: 1.0),
        onTap: (value) {
          handleCallBack();
        },
      ),
    );
  }

  void handleCallBack() {
    widget.eventCallBack!();
  }
}
