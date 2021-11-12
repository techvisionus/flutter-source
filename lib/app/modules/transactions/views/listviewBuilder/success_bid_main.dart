import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/modules/transactions/controllers/transactions_controller.dart';
import 'package:flutter_my_page/app/modules/transactions/views/listviewBuilder/bid_listview.dart';
import 'package:flutter_my_page/app/modules/transactions/views/listviewBuilder/success_bid_listview.dart';
import 'package:flutter_my_page/app/widget/listview_with_loadmore_widget.dart';
import 'package:get/get.dart';

class SuccessBiDMain extends GetView<TransactionsController> {
  bool isReaded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: controller.obx(
        (state) => GetBuilder<TransactionsController>(
          builder: (_dx) => ListViewWithLoadMore(
              scrollController: controller.scrollController,
              coutListDataLoaded: _dx.mListLocalItemBidCar.length,
              counTotalListData:
                  _dx.mTransactionsEntity.bidCarEntity?.data?.length,
              RowEventCallBack: (int index) =>
                  buildDataRow(index, _dx, context),
              pullRefreshCallBack: _dx.pullRefresh),
        ),
        onError: (error) => Text("$error"),
      ),
    );
  }

  InkWell buildDataRow(
      int index, TransactionsController? _dx, BuildContext context) {
    return InkWell(
      child: SuccessBidListView(_dx?.mListLocalItemBidCar[index]),
      onTap: () {},
    );
  }

  bool isPdfFile(String? url) {
    bool isPdf = false;
    RegExp regExp = RegExp(r'.pdf$');
    isPdf = regExp.hasMatch(url!);
    return isPdf;
  }
}
