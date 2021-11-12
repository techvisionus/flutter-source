import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_my_page/app/modules/home/views/expandableType/notification/expandableNoti.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/widget/listview_with_loadmore_widget.dart';
import 'package:flutter_my_page/app/widget/web_view_widget.dart';
import 'package:get/get.dart';

class NotificationMain extends GetView<HomeController> {
  bool isReaded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: controller.obx(
        (state) => GetBuilder<HomeController>(
          builder: (_dx) => ListViewWithLoadMore(
              scrollController: controller.scrollController,
              coutListDataLoaded: _dx.itemsListLoaded.length,
              counTotalListData: _dx.mHomeEntity.notifyEntity?.data?.length,
              RowEventCallBack: (int index) =>
                  buildDataRow(index, _dx, context),
              pullRefreshCallBack: () => _dx.pullRefresh()),
        ),
        onError: (error) => Text("$error"),
      ),
    );
  }

  InkWell buildDataRow(int index, HomeController? _dx, BuildContext context) {
    return InkWell(
        child: ExpandableNoti(_dx?.itemsListLoaded[index], false),
        onTap: () {
          //   showDialog(
          //       context: context,
          //       builder: (BuildContext context) => WebViewWidget(
          //           url: _dx?.itemsListLoaded[index]?.link,
          //           isPdfFile: isPdfFile(_dx?.itemsListLoaded[index]?.link)));
          // },
          controller.getLinkwebview(_dx!.itemsListLoaded[index]?.link);
        });
  }

  bool isPdfFile(String? url) {
    bool isPdf = false;
    RegExp regExp = RegExp(r'.pdf$');
    isPdf = regExp.hasMatch(url!);
    return isPdf;
  }
}
