/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-27 15:55:46
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-08 17:52:10
 */
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/modules/index/controllers/index_controller.dart';
import 'package:flutter_my_page/app/modules/transactions/models/bid_list/bidList.dart';
import 'package:flutter_my_page/app/modules/transactions/models/bid_list/item_bidcar.dart';
import 'package:get/get.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_my_page/app/config/constants.dart';
import 'package:flutter_my_page/app/modules/transactions/models/transactions_entity.dart';
import 'package:flutter_my_page/app/modules/transactions/models/bid_list/bidcarEntity.dart';

class TransactionsController extends GetxController
    with SingleGetTickerProviderMixin, StateMixin {
  final count = 0.obs;
  int page = 1;

  RxInt numberDetailScreen = 0.obs;
  RxInt numberShowDetailBid = 0.obs;
  RxInt numberShowDetailSuccess = 0.obs;

  EasyRefreshController? refreshController;

  TransactionsEntity mTransactionsEntity = TransactionsEntity();
  BidCarEntity bidCarEntity = BidCarEntity();
  BidListEntity bidListEntity = BidListEntity();

  AnimationController? controller;
  AnimationController? animationController;
  RxBool expanded = false.obs;

  // SCROLL EVENT VARIABLES FOR LISTVIEW
  bool upDirection = true;
  ScrollController scrollController = ScrollController();
  RxBool isShowTabBar = true.obs;

  // SCROLL EVENT VARIABLES FOR TAB BAR
  TabController? tabController;
  List<ItemBidCar?> mListLocalItemBidCar = [];
  int currentNumberNotiMain = 0;
  int numberOfPage = 10;
  RxInt currentTabIdx = 0.obs;
  //
  double expandedbid = 0;
  double expandedsuccessbid = 0;

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
    tabController = TabController(vsync: this, length: 2);
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

    getTransactionsData();
  }

  setExpandStatusBid(bool isOn, int numbercar, double expand) {
    expandedbid = expand;
    numberShowDetailBid.value = numbercar;
    print(numbercar);
    update();
  }

  setExpandStatusSuccessBid(bool isOn, int numbercar, double expand) {
    expandedsuccessbid = expand;
    numberShowDetailSuccess.value = numbercar;
    print(numbercar);
    update();
  }

  pullRefresh() {
    print('Pull to refresh!');
  }

  void hideBottomNavbar() {
    var indexController = Get.find<IndexController>();
    indexController.isShowBottomBar.value =
        !indexController.isShowBottomBar.value;
    isShowTabBar.value = !isShowTabBar.value;
    update();
  }

  getTransactionsData() {
    print("Get transactions data");
    if (isTest) {
      // Use dummy data for developing app
      dummyData();
      getNumberOfPage();
      Future.delayed(Duration(milliseconds: 200), () {
        change(mTransactionsEntity, status: RxStatus.success());
      });
    } else {
      // Call API

    }
  }

  _getMoreData() async {
    print("GET MORE DATA");
    await Future.delayed(Duration(milliseconds: 2000));
    getMoreData();
  }

  void getMoreData() async {
    getNumberOfPage();
    update();
  }

  void getNumberOfPage() {
    print("GET NUMBER OF PAGE");
    for (int i = currentNumberNotiMain;
        i < currentNumberNotiMain + numberOfPage;
        i++) {
      if (mListLocalItemBidCar.length ==
          mTransactionsEntity.bidCarEntity?.data?.length) {
        return;
      } else {
        mListLocalItemBidCar.add(mTransactionsEntity.bidCarEntity?.data?[i]);
      }
    }
    currentNumberNotiMain += numberOfPage;
  }

  void dummyData() {
    mTransactionsEntity = TransactionsEntity(new BidCarEntity([
      ItemBidCar(
        number: '1',
        image:
            'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5fc3f4641587348dd9e3bc3d%2F2021-Toyota-Mirai%2F960x0.jpg%3Ffit%3Dscale',
        aabid: 'AA入札',
        location: 'JU東京',
        listnumber: '1234',
        trademark: 'トヨタ',
        species: 'R2 プリウス',
        biddate: '2021年9月1日 10:00',
        biddeadline: '2021年9月1日 11:00',
        bidamount: '2,000,000円',
        startingprice: '1,000,000円',
        inputamount: 'test1',
        increasedamount: 'test1',
        checkdetails: 'test1',
        changecancel: 'test1',
        landstatus: 'test1',
        opportunityamount: 'test1',
        aaoneplastic: 'test1',
        listingstatus: 'test1',
      ),
      ItemBidCar(
        number: '2',
        image:
            'https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5d35eacaf1176b0008974b54%2F0x0.jpg%3FcropX1%3D790%26cropX2%3D5350%26cropY1%3D784%26cropY2%3D3349',
        aabid: 'AA入札',
        location: '日産ﾌﾟﾗｻﾞｿﾙ入札会苫小牧',
        listnumber: '1234',
        trademark: 'トヨタ',
        species: 'R2 プリウス',
        biddate: '2021年9月1日 10:00',
        biddeadline: '2021年9月1日 11:00',
        bidamount: '2,000,000円',
        startingprice: '1,000,000円',
        inputamount: 'test1',
        increasedamount: 'test1',
        checkdetails: 'test1',
        changecancel: 'test1',
        landstatus: 'test1',
        opportunityamount: 'test1',
        aaoneplastic: 'test1',
        listingstatus: 'test1',
      ),
      ItemBidCar(
        number: '3',
        image:
            'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F61574149c5951e0afc33bc40%2FNew-Toyota-Prius-Hybrid-car%2F960x0.jpg%3Ffit%3Dscale',
        aabid: 'AA入札',
        location: 'ヒーローメンバーズオートオークション',
        listnumber: '1234',
        trademark: 'トヨタ',
        species:
            'R2 プリウス species species species species species species species species species species',
        biddate: '2021年9月1日 10:00',
        biddeadline: '2021年9月1日 11:00',
        bidamount: '2,000,000円',
        startingprice: '1,000,000円',
        inputamount: 'test1',
        increasedamount: 'test1',
        checkdetails: 'test1',
        changecancel: 'test1',
        landstatus: 'test1',
        opportunityamount: 'test1',
        aaoneplastic: 'test1',
        listingstatus: 'test1',
      ),
      ItemBidCar(
        number: '4',
        image:
            'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F61574149c5951e0afc33bc40%2FNew-Toyota-Prius-Hybrid-car%2F960x0.jpg%3Ffit%3Dscale',
        aabid: 'AA入札',
        location: 'ヒーローメンバーズオートオークション',
        listnumber: '1234',
        trademark: 'トヨタ',
        species:
            'R2 プリウス species species species species species species species species species species',
        biddate: '2021年9月1日 10:00',
        biddeadline: '2021年9月1日 11:00',
        bidamount: '2,000,000円',
        startingprice: '1,000,000円',
        inputamount: 'test1',
        increasedamount: 'test1',
        checkdetails: 'test1',
        changecancel: 'test1',
        landstatus: 'test1',
        opportunityamount: 'test1',
        aaoneplastic: 'test1',
        listingstatus: 'test1',
      ),
      ItemBidCar(
        number: '5',
        image:
            'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F61574149c5951e0afc33bc40%2FNew-Toyota-Prius-Hybrid-car%2F960x0.jpg%3Ffit%3Dscale',
        aabid: 'AA入札',
        location: 'ヒーローメンバーズオートオークション',
        listnumber: '1234',
        trademark: 'トヨタ',
        species:
            'R2 プリウス species species species species species species species species species species',
        biddate: '2021年9月1日 10:00',
        biddeadline: '2021年9月1日 11:00',
        bidamount: '2,000,000円',
        startingprice: '1,000,000円',
        inputamount: 'test1',
        increasedamount: 'test1',
        checkdetails: 'test1',
        changecancel: 'test1',
        landstatus: 'test1',
        opportunityamount: 'test1',
        aaoneplastic: 'test1',
        listingstatus: 'test1',
      ),
      ItemBidCar(
        number: '6',
        image:
            'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F61574149c5951e0afc33bc40%2FNew-Toyota-Prius-Hybrid-car%2F960x0.jpg%3Ffit%3Dscale',
        aabid: 'AA入札',
        location: 'ヒーローメンバーズオートオークション',
        listnumber: '1234',
        trademark: 'トヨタ',
        species:
            'R2 プリウス species species species species species species species species species species',
        biddate: '2021年9月1日 10:00',
        biddeadline: '2021年9月1日 11:00',
        bidamount: '2,000,000円',
        startingprice: '1,000,000円',
        inputamount: 'test1',
        increasedamount: 'test1',
        checkdetails: 'test1',
        changecancel: 'test1',
        landstatus: 'test1',
        opportunityamount: 'test1',
        aaoneplastic: 'test1',
        listingstatus: 'test1',
      ),
      ItemBidCar(
        number: '7',
        image:
            'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F61574149c5951e0afc33bc40%2FNew-Toyota-Prius-Hybrid-car%2F960x0.jpg%3Ffit%3Dscale',
        aabid: 'AA入札',
        location: 'ヒーローメンバーズオートオークション',
        listnumber: '1234',
        trademark: 'トヨタ',
        species:
            'R2 プリウス species species species species species species species species species species',
        biddate: '2021年9月1日 10:00',
        biddeadline: '2021年9月1日 11:00',
        bidamount: '2,000,000円',
        startingprice: '1,000,000円',
        inputamount: 'test1',
        increasedamount: 'test1',
        checkdetails: 'test1',
        changecancel: 'test1',
        landstatus: 'test1',
        opportunityamount: 'test1',
        aaoneplastic: 'test1',
        listingstatus: 'test1',
      ),
      ItemBidCar(
        number: '8',
        image:
            'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F61574149c5951e0afc33bc40%2FNew-Toyota-Prius-Hybrid-car%2F960x0.jpg%3Ffit%3Dscale',
        aabid: 'AA入札',
        location: 'ヒーローメンバーズオートオークション',
        listnumber: '1234',
        trademark: 'トヨタ',
        species:
            'R2 プリウス species species species species species species species species species species',
        biddate: '2021年9月1日 10:00',
        biddeadline: '2021年9月1日 11:00',
        bidamount: '2,000,000円',
        startingprice: '1,000,000円',
        inputamount: 'test1',
        increasedamount: 'test1',
        checkdetails: 'test1',
        changecancel: 'test1',
        landstatus: 'test1',
        opportunityamount: 'test1',
        aaoneplastic: 'test1',
        listingstatus: 'test1',
      ),
      ItemBidCar(
        number: '9',
        image:
            'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F61574149c5951e0afc33bc40%2FNew-Toyota-Prius-Hybrid-car%2F960x0.jpg%3Ffit%3Dscale',
        aabid: 'AA入札',
        location: 'ヒーローメンバーズオートオークション',
        listnumber: '1234',
        trademark: 'トヨタ',
        species:
            'R2 プリウス species species species species species species species species species species',
        biddate: '2021年9月1日 10:00',
        biddeadline: '2021年9月1日 11:00',
        bidamount: '2,000,000円',
        startingprice: '1,000,000円',
        inputamount: 'test1',
        increasedamount: 'test1',
        checkdetails: 'test1',
        changecancel: 'test1',
        landstatus: 'test1',
        opportunityamount: 'test1',
        aaoneplastic: 'test1',
        listingstatus: 'test1',
      ),
      ItemBidCar(
        number: '10',
        image:
            'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F61574149c5951e0afc33bc40%2FNew-Toyota-Prius-Hybrid-car%2F960x0.jpg%3Ffit%3Dscale',
        aabid: 'AA入札',
        location: 'ヒーローメンバーズオートオークション',
        listnumber: '1234',
        trademark: 'トヨタ',
        species:
            'R2 プリウス species species species species species species species species species species',
        biddate: '2021年9月1日 10:00',
        biddeadline: '2021年9月1日 11:00',
        bidamount: '2,000,000円',
        startingprice: '1,000,000円',
        inputamount: 'test1',
        increasedamount: 'test1',
        checkdetails: 'test1',
        changecancel: 'test1',
        landstatus: 'test1',
        opportunityamount: 'test1',
        aaoneplastic: 'test1',
        listingstatus: 'test1',
      ),
    ]));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
