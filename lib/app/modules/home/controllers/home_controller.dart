/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-19 16:10:54
 * @LastEditors: saphir
 * @LastEditTime: 2021-06-04 08:52:16
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_my_page/app/config/constants.dart';
import 'package:flutter_my_page/app/modules/home/models/home_entity.dart';
import 'package:flutter_my_page/app/modules/home/models/item_notifi.dart';
import 'package:flutter_my_page/app/modules/home/models/notifyEntity.dart';
import 'package:flutter_my_page/app/modules/home/service/home_service.dart';
import 'package:flutter_my_page/app/modules/index/controllers/index_controller.dart';
import 'package:flutter_my_page/app/utils/network/task_type.dart';
import 'package:flutter_my_page/app/widget/dialog/mypage_dialog.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with SingleGetTickerProviderMixin, StateMixin<HomeEntity> {
  int page = 1;
  EasyRefreshController? refreshController;
  HomeEntity mHomeEntity = HomeEntity();
  NotifyEntity notifyEntity = NotifyEntity();
  AnimationController? animationController;

  // SCROLL EVENT VARIABLES FOR LISTVIEW
  bool upDirection = true;
  ScrollController scrollController = ScrollController();
  RxBool isShowTabBar = true.obs;

  //Webview show
  RxBool isShowWebview = false.obs;
  String linkWebview = '';

  // SCROLL EVENT VARIABLES FOR TAB BAR
  TabController? tabController;
  List<ItemNotifi?> itemsListLoaded = [];
  int currentNumberNotiMain = 0;
  int numberOfPage = 10;
  RxInt currentTabIdx = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print(refreshController.toString());

    // 1. Listen to scroll direction in ListView
    // START - GET SCROLL EVENT TO HIDE BOTTOM BAR //
    refreshController = EasyRefreshController();
    var indexController = Get.find<IndexController>();
    scrollController = scrollController
      ..addListener(() {
        upDirection = scrollController.position.userScrollDirection ==
            ScrollDirection.forward;

        if (upDirection != true) {
          print("SCROLL DOWN EVENT");
          indexController.isShowBottomBar.value = false;
          isShowTabBar.value = false;
        } else {
          indexController.isShowBottomBar.value = true;
          isShowTabBar.value = true;
        }

        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          _getMoreData();
        }

        update();
      });
    // END - GET SCROLL EVENT TO HIDE BOTTOM BAR //

    // 2.Setting animation
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    // 3. Listen to tab event
    tabController = TabController(vsync: this, length: 4);
    tabController!.addListener(() {
      print('[Tab event] my index is ' + tabController!.index.toString());
      currentTabIdx.value = tabController!.index;
      indexController.isShowBottomBar.value = true;
      isShowTabBar.value = true;
      update();
    });

    // 4.
    tabController!.animation!
      ..addListener(() {
        int value = (tabController!.animation!.value).round();
        if (value != currentTabIdx.value) {
          print('[Tab Animation Event] my index is' +
              tabController!.index.toString());
          currentTabIdx.value = value;
        }
      });

    // 3. Get notice data
    getHomeData();
  }

  ///Get homepage data
  getHomeData() {
    print("Get home data");
    if (isTest) {
      // Use dummy data for developing app
      dummyData();
      setupData(false);
      Future.delayed(Duration(milliseconds: 200), () {
        change(mHomeEntity, status: RxStatus.success());
      });
    } else {
      // Call API
      callApiGetNotices();
    }
  }

  callApiGetNotices() {
    HomeService.getNotices().then((value) {
      switch (value.result) {
        case TaskResult.success:
          mHomeEntity.notifyEntity = value.data;
          setupData(false);
          change(mHomeEntity, status: RxStatus.success());
          break;
        default:
          // Case show dialog cant connect to server
          if (value.messageData == null) {
            change(null, status: RxStatus.empty());
            MyPageDialog.showDialog("Error", "content", false);
          } else {
            change(mHomeEntity,
                status: RxStatus.error("${value.messageData!.content}"));
          }
      }
    });
  }

  _getMoreData() async {
    print("GET MORE DATA");
    await Future.delayed(Duration(milliseconds: 2000));
    getMoreData();
  }

  void getMoreData() async {
    setupData(true);
    update();
  }

  void pullRefresh() {
    print("Pull Refresh Data");
    if (!isTest) {
      callApiGetNotices();
    }
  }

  // True: Load More, False: Get Data From API
  void setupData(bool loadMore) {
    print("GET NUMBER OF PAGE");
    // False: Reset Data Local before Load Data from Server
    resetLocalData(loadMore);
    addLocalDataLoadMore();
  }

  addLocalDataLoadMore() {
    for (int i = currentNumberNotiMain;
        i < currentNumberNotiMain + numberOfPage;
        i++) {
      if (itemsListLoaded.length == mHomeEntity.notifyEntity?.data?.length) {
        return;
      } else {
        itemsListLoaded.add(mHomeEntity.notifyEntity?.data?[i]);
      }
    }
    currentNumberNotiMain += numberOfPage;
  }

  void resetLocalData(bool loadMore) {
    if (loadMore == false) {
      currentNumberNotiMain = 0;
      itemsListLoaded.clear();
    }
  }

  void dummyData() {
    mHomeEntity = HomeEntity(new NotifyEntity([
      ItemNotifi(
          id: '1',
          noticeKbn: '1',
          title: '10/18 Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/pdf/20111017.pdf',
          fromDate: '2011/10/18 17:00:01'),
      ItemNotifi(
          id: '2',
          noticeKbn: '1',
          title: '10/20 Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111020a.asp',
          fromDate: '2011/10/18 20:00:00'),
      ItemNotifi(
          id: '3',
          noticeKbn: '1',
          title: 'Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111014c.asp',
          fromDate: '2011/10/14 0:00:00'),
      ItemNotifi(
          id: '4',
          noticeKbn: '1',
          title: 'Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111019a.asp',
          fromDate: '2011/10/19 10:00:00'),
      ItemNotifi(
          id: '5',
          noticeKbn: '1',
          title: 'Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111020a.asp',
          fromDate: '2011/10/18 20:00:00'),
      ItemNotifi(
          id: '6',
          noticeKbn: '1',
          title: 'Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111020a.asp',
          fromDate: '2011/10/18 20:00:00'),
      ItemNotifi(
          id: '7',
          noticeKbn: '1',
          title: '10/20 Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111020a.asp',
          fromDate: '2011/10/18 20:00:00'),
      ItemNotifi(
          id: '8',
          noticeKbn: '1',
          title: '10/20 Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111020a.asp',
          fromDate: '2011/10/18 20:00:00'),
      ItemNotifi(
          id: '9',
          noticeKbn: '1',
          title: '10/20 Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111020a.asp',
          fromDate: '2011/10/18 20:00:00'),
      ItemNotifi(
          id: '10',
          noticeKbn: '1',
          title: '10/20 Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111020a.asp',
          fromDate: '2011/10/18 20:00:00'),
      ItemNotifi(
          id: '1',
          noticeKbn: '1',
          title: '10/18 Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/pdf/20111017.pdf',
          fromDate: '2011/10/18 17:00:01'),
      ItemNotifi(
          id: '2',
          noticeKbn: '1',
          title: '10/20 Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111020a.asp',
          fromDate: '2011/10/18 20:00:00'),
      ItemNotifi(
          id: '3',
          noticeKbn: '1',
          title: 'AS Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111014c.asp',
          fromDate: '2011/10/14 0:00:00'),
      ItemNotifi(
          id: '4',
          noticeKbn: '1',
          title: 'AA Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111019a.asp',
          fromDate: '2011/10/19 10:00:00'),
      ItemNotifi(
          id: '5',
          noticeKbn: '1',
          title: '10/20 Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111020a.asp',
          fromDate: '2011/10/18 20:00:00'),
      ItemNotifi(
          id: '6',
          noticeKbn: '1',
          title: '10/20 Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111020a.asp',
          fromDate: '2011/10/18 20:00:00'),
      ItemNotifi(
          id: '7',
          noticeKbn: '1',
          title: '10/20 Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111020a.asp',
          fromDate: '2011/10/18 20:00:00'),
      ItemNotifi(
          id: '8',
          noticeKbn: '1',
          title: '10/20 Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111020a.asp',
          fromDate: '2011/10/18 20:00:00'),
      ItemNotifi(
          id: '9',
          noticeKbn: '1',
          title: '10/20 Thông báo test demo!',
          message: '',
          link: 'https://asnet.autoserver.co.jp/news/20111020a.asp',
          fromDate: '2011/10/18 20:00:00'),
    ]));
  }

  getLinkwebview(String? url) {
    this.linkWebview = url!;
    this.isShowWebview = true.obs;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    refreshController?.dispose();
  }
}
