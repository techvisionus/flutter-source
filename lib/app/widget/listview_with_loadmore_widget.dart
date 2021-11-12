import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:get/get.dart';

class ListViewWithLoadMore extends StatefulWidget {
  @override
  _ListViewWithLoadMoreState createState() => _ListViewWithLoadMoreState();
  ScrollController? scrollController;
  int coutListDataLoaded;
  int? counTotalListData;
  Function(int) RowEventCallBack;
  Function() pullRefreshCallBack;


  ListViewWithLoadMore({
    required this.scrollController,
    required this.coutListDataLoaded,
    required this.counTotalListData,
    required this.RowEventCallBack,
    required this.pullRefreshCallBack
  });
}

class _ListViewWithLoadMoreState extends State<ListViewWithLoadMore> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: ListView.builder(
            controller: widget.scrollController,
            padding: EdgeInsets.only(top: Dimens.zero),
            itemBuilder: (BuildContext context, int index) {
              // Load UI Load More
              return updateDataRow(index, context,widget.coutListDataLoaded,widget.counTotalListData);
            },
            //+1: Using for Row Load More UI
            itemCount: widget.coutListDataLoaded + 1),
      ),
    );
  }

  Widget completed() {
    return Container(
      height: Dimens.size55,
      child: Center(
        child: Text('COMPLETE_LOAD_MORE'.tr,
            style: new TextStyle(
              fontSize: DimenFont.sp17,
              fontFamily: "NotoSansJPMedium",
            )),
      ),
    );
  }

  Widget showLoadMoreUI() {
    Widget body;
    body = CupertinoActivityIndicator();
    return Container(
      height: Dimens.size55,
      child: body,
    );
  }

  Widget updateDataRow(int index, BuildContext context, int? countListDataLoaded,int? countTotalListData) {
    // LOAD MORE UI

    if (index == widget.coutListDataLoaded) {
      if (widget.coutListDataLoaded == widget.counTotalListData) {
        return completed();
      } else {
        return showLoadMoreUI();
      }
    } else {
      return dataRow(index);
    }
  }

  // Reload API
  Future<void> _pullRefresh() async {
    widget.pullRefreshCallBack();
  }

  Widget dataRow(int index){
    return widget.RowEventCallBack(index);
  }
}
