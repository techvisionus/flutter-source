/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-20 09:21:53
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-08 17:35:08
 */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/modules/transactions/views/listviewBuilder/bid_main.dart';
import 'package:flutter_my_page/app/modules/transactions/views/listviewBuilder/exhibition_main.dart';
import 'package:flutter_my_page/app/modules/transactions/views/listviewBuilder/success_bid_main.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:flutter_my_page/app/widget/decoration/tab_decoration_widget.dart';
import 'package:flutter_my_page/app/widget/info_button_widget.dart';
import 'package:get/get.dart';
import '../controllers/transactions_controller.dart';
import 'package:flustars/flustars.dart';

class TransactionsPage extends GetView<TransactionsController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            // Build tab header 買う / 売る
            _buildCommerceTab(),
            // Content, include another tab 入札・申込リスト / 落札リスト
            _buildCommerceTabView(),
          ],
        ),
      ),
    );
  }

  // Build tab header 買う / 売る
  Widget _buildCommerceTab() {
    return Obx(
      () => AnimatedContainer(
        color: ResourceColors.color_d5d5d5,
        duration: const Duration(milliseconds: 500),
        height: controller.isShowTabBar.value ? 55.0 : 0,
        child: Wrap(
          children: [
            _buildCommerceTabCreate(),
          ],
        ),
      ),
    );
  }

  Visibility _buildCommerceTabCreate() {
    return Visibility(
      visible: controller.isShowTabBar.value,
      child: Container(
        padding:
            EdgeInsets.only(top: 6.0, right: Dimens.size5, left: Dimens.size5),
        child: TabBar(
          controller: controller.tabController,
          tabs: [
            tabContainerCommerce('BUY_TAB_TITLE'.tr,
                tabIdx: 0, currentTabIdx: controller.currentTabIdx.value),
            tabContainerCommerce('SELL_TAB_TITLE'.tr,
                tabIdx: 1, currentTabIdx: controller.currentTabIdx.value),
          ],
          labelColor: ResourceColors.text_black,
          unselectedLabelColor: ResourceColors.color_4674ec,
          indicatorColor: ResourceColors.color_white,
          indicatorWeight: 1,
          labelPadding: EdgeInsets.symmetric(horizontal: 1.0),
          onTap: (value) {
            print(value);
            // controller.getHomeData();
          },
        ),
      ),
    );
  }

  Container tabContainerCommerce(String tabName,
      {required int tabIdx, required int currentTabIdx}) {
    return Container(
      decoration: tabIdx == currentTabIdx
          ? buildBoxDecoration(
              0, ResourceColors.color_d5, ResourceColors.color_white)
          : buildBoxDecoration(
              2, ResourceColors.color_d5, ResourceColors.backgroundColor),
      height: 48.0, //Dimens.size45,
      width: ScreenUtil.getInstance().screenWidth - 30,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Center(
          child: Text(tabName,
              style: new TextStyle(
                fontSize:
                    tabIdx == currentTabIdx ? DimenFont.sp17 : DimenFont.middle,
                fontFamily: tabIdx == currentTabIdx
                    ? "NotoSansJPBold"
                    : "NotoSansJPMedium",
              )),
        ),
      ),
    );
  }

  // Content, include another tab 入札・申込リスト / 落札リスト
  Expanded _buildCommerceTabView() {
    return Expanded(
      child: TabBarView(
        controller: controller.tabController,
        children: [
          // Auction page
          Container(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                body: Column(
                  children: [
                    // Build tab header 入札・申込リスト / 落札リスト
                    // Include title 入札・申込中: 15台 and Search/filter
                    _buildAuctionTab(),
                    // Content: car list
                    _buildAuctionTabView(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                body: Column(
                  children: [
                    // Build tab header ASワンプラ出品リスト/AA代行出品リスト/出品成約リスト
                    // Include title 出品中：4台　商談中：1台 and Search/filter
                    _buildSellTab(),
                    // Content: car list
                    _buildSellTabView(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildAuctionTabView() {
    return Expanded(
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          // 入札・申込リスト list
          Container(
            color: ResourceColors.color_FFFFFF,
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Detail 入札・申込リスト list
                _buildDetailBidList(),
              ],
            ),
          ),
          // 落札リスト list
          Container(
            color: ResourceColors.color_FFFFFF,
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Detail 入札・申込リスト list
                _buildDetailSuccessBidList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildSellTabView() {
    return Expanded(
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          // 入札・申込リスト list
          Container(
            color: ResourceColors.color_FFFFFF,
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Detail 入札・申込リスト list
                _buildDetailExhibitionList(),
              ],
            ),
          ),
          // 落札リスト list
          Container(
            color: ResourceColors.color_FFFFFF,
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('TEST')
                // Detail 入札・申込リスト list
                // _buildDetailSuccessBidList(),
              ],
            ),
          ),
          Container(
            color: ResourceColors.color_FFFFFF,
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('TEST')
                // Detail 入札・申込リスト list
                // _buildDetailSuccessBidList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Search info 入札・申込リスト list
  Widget _buildSearchinfoBid() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      color: ResourceColors.color_FFFFFF,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Header info number car
          Container(
            decoration: BoxDecoration(
              color: ResourceColors.color_ebf0f6,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'BIDDING'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: DimenFont.sp15,
                      fontWeight: FontWeight.w800,
                      fontFamily: "NotoSansJPBold",
                    ),
                  ),
                  Text(
                    ' 15',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ResourceColors.color_e41010,
                      fontSize: DimenFont.sp20,
                      fontWeight: FontWeight.w900,
                      fontFamily: "NotoSansJPBold",
                    ),
                  ),
                  Text(
                    '台',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ResourceColors.color_e41010,
                      fontSize: DimenFont.sp15,
                      fontWeight: FontWeight.w800,
                      fontFamily: "NotoSansJPBold",
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Header option filter and sort
          Container(
            height: 45.0,
            padding: EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 45,
                  width: 135,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '15台',
                        style: TextStyle(
                          fontSize: DimenFont.sp18,
                          color: ResourceColors.color_e41010,
                          fontWeight: FontWeight.w900,
                          fontFamily: "NotoSansJPBold",
                        ),
                      ),
                      Text(
                        '開催日降順',
                        style: TextStyle(
                          fontSize: DimenFont.sp10,
                          color: ResourceColors.color_888888,
                          fontFamily: "NotoSansJPBold",
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      InfoButtton(
                        url: 'assets/images/sort_car.svg',
                        label: '並べ替え',
                        right: false,
                        labelSize: 20,
                        onPressed: () {
                          // dosomething
                          // sort_car
                          print("sort_car click");
                        },
                      ),
                      SizedBox(width: 1.0),
                      InfoButtton(
                        url: 'assets/images/filter_car.svg',
                        label: '絞り込み',
                        labelSize: 16,
                        right: true,
                        onPressed: () {
                          // dosomething
                          // filter_car
                          print("filter_car click");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Search info 落札リスト list
  Widget _buildSearchinfoSuccessBid() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      color: ResourceColors.color_FFFFFF,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Header info number car
          Container(
            decoration: BoxDecoration(
              color: ResourceColors.color_ebf0f6,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '本日落札：',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: DimenFont.sp15,
                      fontWeight: FontWeight.w800,
                      fontFamily: "NotoSansJPBold",
                    ),
                  ),
                  Text(
                    '5',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ResourceColors.color_e41010,
                      fontSize: DimenFont.sp20,
                      fontWeight: FontWeight.w900,
                      fontFamily: "NotoSansJPBold",
                    ),
                  ),
                  Text(
                    '台',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ResourceColors.color_e41010,
                      fontSize: DimenFont.sp15,
                      fontWeight: FontWeight.w800,
                      fontFamily: "NotoSansJPBold",
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    '今月落札: ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: DimenFont.sp15,
                      fontWeight: FontWeight.w800,
                      fontFamily: "NotoSansJPBold",
                    ),
                  ),
                  Text(
                    '123',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ResourceColors.color_e41010,
                      fontSize: DimenFont.sp20,
                      fontWeight: FontWeight.w900,
                      fontFamily: "NotoSansJPBold",
                    ),
                  ),
                  Text(
                    '台',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ResourceColors.color_e41010,
                      fontSize: DimenFont.sp15,
                      fontWeight: FontWeight.w800,
                      fontFamily: "NotoSansJPBold",
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Header option filter and sort
          Container(
            height: 45.0,
            padding: EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 45,
                  width: 135,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '5台',
                        style: TextStyle(
                          fontSize: DimenFont.sp18,
                          color: ResourceColors.color_e41010,
                          fontWeight: FontWeight.w900,
                          fontFamily: "NotoSansJPBold",
                        ),
                      ),
                      Text(
                        '落札日降順',
                        style: TextStyle(
                          fontSize: DimenFont.sp10,
                          color: ResourceColors.color_888888,
                          fontFamily: "NotoSansJPBold",
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      InfoButtton(
                        url: 'assets/images/sort_car.svg',
                        label: '並べ替え',
                        right: false,
                        labelSize: 20,
                        onPressed: () {
                          // dosomething
                          // sort_car
                          print("sort_car click");
                        },
                      ),
                      SizedBox(width: 1.0),
                      InfoButtton(
                        url: 'assets/images/filter_car.svg',
                        label: '絞り込み',
                        labelSize: 16,
                        right: true,
                        onPressed: () {
                          // dosomething
                          // filter_car
                          print("filter_car click");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Search info ASワンプラ出品リスト list
  Widget _buildSearchinfoExhibition() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      color: ResourceColors.color_FFFFFF,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Header info number car
          Container(
            decoration: BoxDecoration(
              color: ResourceColors.color_ebf0f6,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '出品中：',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: DimenFont.sp15,
                      fontWeight: FontWeight.w800,
                      fontFamily: "NotoSansJPBold",
                    ),
                  ),
                  Text(
                    '4',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ResourceColors.color_e41010,
                      fontSize: DimenFont.sp20,
                      fontWeight: FontWeight.w900,
                      fontFamily: "NotoSansJPBold",
                    ),
                  ),
                  Text(
                    '台',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ResourceColors.color_e41010,
                      fontSize: DimenFont.sp15,
                      fontWeight: FontWeight.w800,
                      fontFamily: "NotoSansJPBold",
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    '商談中: ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: DimenFont.sp15,
                      fontWeight: FontWeight.w800,
                      fontFamily: "NotoSansJPBold",
                    ),
                  ),
                  Text(
                    '1',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ResourceColors.color_e41010,
                      fontSize: DimenFont.sp20,
                      fontWeight: FontWeight.w900,
                      fontFamily: "NotoSansJPBold",
                    ),
                  ),
                  Text(
                    '台',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ResourceColors.color_e41010,
                      fontSize: DimenFont.sp15,
                      fontWeight: FontWeight.w800,
                      fontFamily: "NotoSansJPBold",
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Header option filter and sort
          Container(
            height: 45.0,
            padding: EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 45,
                  width: 135,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '15台',
                        style: TextStyle(
                          fontSize: DimenFont.sp18,
                          color: ResourceColors.color_e41010,
                          fontWeight: FontWeight.w900,
                          fontFamily: "NotoSansJPBold",
                        ),
                      ),
                      Text(
                        '更新日降順',
                        style: TextStyle(
                          fontSize: DimenFont.sp10,
                          color: ResourceColors.color_888888,
                          fontFamily: "NotoSansJPBold",
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      InfoButtton(
                        url: 'assets/images/sort_car.svg',
                        label: '並べ替え',
                        right: false,
                        labelSize: 20,
                        onPressed: () {
                          // dosomething
                          // sort_car
                          print("sort_car click");
                        },
                      ),
                      SizedBox(width: 1.0),
                      InfoButtton(
                        url: 'assets/images/filter_car.svg',
                        label: '絞り込み',
                        labelSize: 16,
                        right: true,
                        onPressed: () {
                          // dosomething
                          // filter_car
                          print("filter_car click");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // DETAIL BID CAR LIST
  Widget _buildDetailBidList() {
    return Expanded(
      child: BiDMain(),
    );
  }

  // DETAIL SUCCESS BID CAR LIST

  Widget _buildDetailSuccessBidList() {
    return Expanded(
      child: SuccessBiDMain(),
    );
  }

  // DETAIL BID CAR LIST
  Widget _buildDetailExhibitionList() {
    return Expanded(
      child: ExhibitionMain(),
    );
  }

  // Build tab header 入札・申込リスト / 落札リスト
  // Include title 入札・申込中: 15台 and Search/filter
  Widget _buildAuctionTab() {
    return Obx(
      () => AnimatedContainer(
        color: ResourceColors.color_FFFFFF,
        duration: const Duration(milliseconds: 500),
        // height: controller.isShowTabBar.value ? 160.0 : 0,
        height: controller.isShowTabBar.value ? 160.0 : 0,
        child: Wrap(
          children: [
            // Build tab header 入札・申込リスト / 落札リスト
            _buildAuctionTabCreate(),
            // Build 入札・申込中: 15台 and Search/filter
            // _buildSearchinfoBid(),
            // ignore: unrelated_type_equality_checks
            controller.numberDetailScreen.value == 1
                ? _buildSearchinfoSuccessBid()
                : _buildSearchinfoBid()
          ],
        ),
      ),
    );
  }

  // Build tab header ASワンプラ出品リスト/AA代行出品リスト/出品成約リスト
  // Include title 出品中：4台　商談中：1台 and Search/filter
  Widget _buildSellTab() {
    return Obx(
      () => AnimatedContainer(
        color: ResourceColors.color_FFFFFF,
        duration: const Duration(milliseconds: 500),
        // height: controller.isShowTabBar.value ? 160.0 : 0,
        height: controller.isShowTabBar.value ? 160.0 : 0,
        child: Wrap(
          children: [
            // Build tab header 入札・申込リスト / 落札リスト
            _buildSellTabCreate(),
            // Build 入札・申込中: 15台 and Search/filter
            // _buildSearchinfoBid(),
            // ignore: unrelated_type_equality_checks
            controller.numberDetailScreen.value == 3
                ? _buildSearchinfoSuccessBid()
                : _buildSearchinfoExhibition()
          ],
        ),
      ),
    );
  }

  // Build tab header 入札・申込リスト / 落札リスト
  Container _buildAuctionTabCreate() {
    return Container(
      color: ResourceColors.color_white,
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              // 1. Divider
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Divider(
                  height: 1,
                  thickness: 3,
                  color: ResourceColors.color_d5d5d5,
                ),
              ),
              // 2. Tab header
              Container(
                child: TabBar(
                  tabs: [
                    tabContainerAuction(
                        'BID_APP_TAB_TITLE'.tr,
                        EdgeInsets.fromLTRB(Dimens.zero, Dimens.zero,
                            Dimens.zero, Dimens.zero)),
                    tabContainerAuction(
                        'BID_SUCCES_TAB_TITLE'.tr,
                        EdgeInsets.fromLTRB(Dimens.zero, Dimens.zero,
                            Dimens.zero, Dimens.zero)),
                  ],
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: ResourceColors.text_black,
                  labelStyle: TextStyle(fontWeight: FontWeight.w700),
                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w100),
                  unselectedLabelColor: ResourceColors.color_4674ec,
                  indicatorColor: ResourceColors.color_3a6ea5,
                  indicatorWeight: 3,
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  onTap: (value) {
                    print('buy tab' + value.toString());
                    if (value == 0) {
                      controller.numberDetailScreen.value = 0;
                    } else
                      controller.numberDetailScreen.value = 1;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildSellTabCreate() {
    return Container(
      color: ResourceColors.color_white,
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              // 1. Divider
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Divider(
                  height: 1,
                  thickness: 3,
                  color: ResourceColors.color_d5d5d5,
                ),
              ),
              // 2. Tab header
              Container(
                child: TabBar(
                  tabs: [
                    tabContainerAuction(
                        'EXHIBITION_APP_TAB_TITLE'.tr,
                        EdgeInsets.fromLTRB(Dimens.zero, Dimens.zero,
                            Dimens.zero, Dimens.zero)),
                    tabContainerAuction(
                        'AGENCY_TAB_TITLE'.tr,
                        EdgeInsets.fromLTRB(Dimens.zero, Dimens.zero,
                            Dimens.zero, Dimens.zero)),
                    tabContainerAuction(
                        'CONTRACT_TAB_TITLE'.tr,
                        EdgeInsets.fromLTRB(Dimens.zero, Dimens.zero,
                            Dimens.zero, Dimens.zero)),
                  ],
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: ResourceColors.text_black,
                  unselectedLabelColor: ResourceColors.color_4674ec,
                  labelStyle: TextStyle(fontWeight: FontWeight.w700),
                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w100),
                  indicatorColor: ResourceColors.color_3a6ea5,
                  indicatorWeight: 3,
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  onTap: (value) {
                    print('sell tab' + value.toString());
                    if (value == 0) {
                      controller.numberDetailScreen.value = 2;
                    } else
                      controller.numberDetailScreen.value = 3;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding tabContainerAuction(String tabName, EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: Container(
        color: ResourceColors.color_FFFFFF,
        height: 45.0, //Dimens.size45,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
          child: Center(
            child: Text(tabName,
                style: new TextStyle(
                  fontSize: DimenFont.sp15,
                  // fontWeight: FontWeight.w700,
                  fontFamily: "NotoSansJPMedium",
                )),
          ),
        ),
      ),
    );
  }
}
