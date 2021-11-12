import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:flutter_my_page/app/widget/decoration/tab_decoration_widget.dart';

class TabContainer extends StatefulWidget {
  final String? tabName;
  double? height;
  double? width;
  int? tabIdx;
  int? currentTab;

  TabContainer({required this.tabName, this.tabIdx, this.currentTab});

  @override
  _TabContainerState createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isCurrentTab()
          ? buildBoxDecoration(
              0, ResourceColors.color_d5, ResourceColors.color_white)
          : buildBoxDecoration(
              2, ResourceColors.color_d5, ResourceColors.backgroundColor),
      height: 48.0,
      width: Dimens.size92,
      child: Center(
        child: Text(widget.tabName.toString(),
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: isCurrentTab() ? DimenFont.sp17 : DimenFont.middle,
              fontFamily:
                  isCurrentTab() ? "NotoSansJPBold" : "NotoSansJPMedium",
            )),
      ),
    );
  }

  bool isCurrentTab() {
    if (widget.currentTab == widget.tabIdx) {
      return true;
    } else {
      return false;
    }
  }
}
