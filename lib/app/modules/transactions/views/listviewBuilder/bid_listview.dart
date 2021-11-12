import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/modules/transactions/controllers/transactions_controller.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:flutter_my_page/app/widget/dot_widget.dart';
import 'package:flutter_my_page/app/widget/running_text_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_my_page/app/config/constants.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_my_page/app/modules/transactions/models/bid_list/item_bidcar.dart';
import 'package:marquee/marquee.dart';

class BidListView extends GetView<TransactionsController> {
  final ItemBidCar? itemBidCar;
  BidListView(this.itemBidCar);
  @override
  Widget build(BuildContext context) {
    return _buildCardCarDetail();
  }

  Widget _buildCardCarDetail() {
    return Container(
      padding: EdgeInsets.only(bottom: 3.0),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 7.0),
            child: Column(
              children: <Widget>[
                // Header Divider
                _buildHeaderDivider(),
                // Table 1 detail car when show part
                _buildBidCarDetailsTable1(),

                // Table 2 detail car when show full
                _buildBidCarDetailsTable2(),
                _buildButtonShow(),
                _buildButtonClose(),
              ],
            ),
          ),
          // Serial number of the vehicle
          _buildNumberCar(),
        ],
      ),
    );
  }

  // Table 1 detail car when show part
  Widget _buildBidCarDetailsTable1() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Obx(
          () => Container(
            height: controller.numberShowDetailBid.value !=
                    int.parse(itemBidCar!.number!.toString())
                ? 178
                : 250,
            width: double.maxFinite,
            color: ResourceColors.color_f7f7f7,
            child: Container(
              child: Row(
                children: [
                  // Left side content
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Image.network(itemBidCar!.image!.toString(),
                              width: 90, height: 67.5, fit: BoxFit.fill),
                          SizedBox(height: 5.0),
                          Container(
                            width: 90,
                            height: 20,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ResourceColors.color_289f74,
                                    width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Text(itemBidCar!.aabid!.toString(),
                                  style: TextStyle(
                                    fontSize: DimenFont.sp12,
                                    color: ResourceColors.color_289f74,
                                    fontFamily: "NotoSansJPRegular",
                                  )),
                            ),
                          ),
                          // Build location
                          Container(
                            width: 90,
                            height: 20,
                            child: Center(
                              child: itemBidCar!.location!.length < 7
                                  ? _buildNormalText(
                                      itemBidCar!.location!.toString())
                                  : RunningTextWidget(
                                      text: itemBidCar!.location!.toString()),
                            ),
                          ),
                          Container(
                            width: 90,
                            height: 25,
                            color: ResourceColors.color_333333,
                            child: Center(
                              child: Text(
                                '出品番号',
                                style: TextStyle(
                                  color: ResourceColors.color_FFFFFF,
                                  fontSize: DimenFont.sp12,
                                  fontFamily: "NotoSansJPRegular",
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 90,
                            height: 25,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: ResourceColors.color_333333,
                                  width: 2.0,
                                  style: BorderStyle.solid),
                            ),
                            child: Center(
                              child: Text(
                                '1234',
                                style: TextStyle(
                                  fontSize: DimenFont.sp12,
                                  fontFamily: "NotoSansJPRegular",
                                  color: ResourceColors.color_333333,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Obx(
                            () => Visibility(
                              visible: controller.numberShowDetailBid.value ==
                                  int.parse(itemBidCar!.number!.toString()),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    '9月1日開催',
                                    style: TextStyle(
                                      fontSize: DimenFont.sp12,
                                      fontFamily: "NotoSansJPRegular",
                                      color: ResourceColors.color_333333,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Visibility(
                              visible: controller.numberShowDetailBid.value ==
                                  int.parse(itemBidCar!.number!.toString()),
                              child: Container(
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: Column(
                                  children: [
                                    SizedBox(height: 5.0),
                                    DotWidget(
                                      dashColor: ResourceColors.color_727272,
                                      dashHeight: 2,
                                      dashWidth: 2,
                                    ),
                                    SizedBox(height: 5.0),
                                    Center(
                                      child: Text(
                                        '第1230回',
                                        style: TextStyle(
                                          fontSize: DimenFont.sp12,
                                          fontFamily: "NotoSansJPRegular",
                                          color: ResourceColors.color_333333,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Right side content
                  Expanded(
                    flex: 8,
                    child: Container(
                      width: 250,
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'トヨタ',
                            style: TextStyle(
                              fontSize: DimenFont.sp14,
                              fontFamily: "NotoSansJPRegular",
                              color: ResourceColors.color_333333,
                            ),
                          ),
                          Container(
                            width: double.maxFinite,
                            height: 20,
                            child: Container(
                              child: itemBidCar!.species!.length < 70
                                  ? _buildNormalText(
                                      itemBidCar!.species!.toString())
                                  : RunningTextWidget(
                                      text: itemBidCar!.species!.toString()),
                            ),
                          ),
                          SizedBox(height: 2.0),
                          DotWidget(
                            dashColor: ResourceColors.color_727272,
                            dashHeight: 2,
                            dashWidth: 2,
                            totalWidth: 240,
                          ),

                          SizedBox(height: 5.0),
                          // Bid time
                          Container(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                //Bid date
                                Container(
                                  width: 90,
                                  height: 22,
                                  decoration: BoxDecoration(
                                      color: ResourceColors.color_333333,
                                      border: Border.all(
                                          color: ResourceColors.color_333333,
                                          width: 2.0),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      '入札日',
                                      style: TextStyle(
                                        fontSize: DimenFont.sp12,
                                        fontFamily: "NotoSansJPRegular",
                                        color: ResourceColors.color_FFFFFF,
                                      ),
                                    ),
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    '2021年9月1日 10:00',
                                    style: TextStyle(
                                      fontSize: DimenFont.sp12,
                                      fontFamily: "NotoSansJPRegular",
                                      color: ResourceColors.color_333333,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                //Bid date
                                Container(
                                  width: 90,
                                  height: 22,
                                  decoration: BoxDecoration(
                                      color: ResourceColors.color_FFFFFF,
                                      border: Border.all(
                                          color: ResourceColors.color_333333,
                                          width: 2.0),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      '入札締切',
                                      style: TextStyle(
                                        fontSize: DimenFont.sp12,
                                        fontFamily: "NotoSansJPRegular",
                                        color: ResourceColors.color_333333,
                                      ),
                                    ),
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    '2021年9月1日 11:00',
                                    style: TextStyle(
                                      fontSize: DimenFont.sp12,
                                      fontFamily: "NotoSansJPRegular",
                                      color: ResourceColors.color_333333,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //Bid amount

                          SizedBox(height: 10.0),
                          Container(
                            width: double.maxFinite,
                            height: 50,
                            decoration: BoxDecoration(
                              color: ResourceColors.color_FFFFFF,
                              border: Border(
                                  top: BorderSide(
                                    width: 2.0,
                                    color: ResourceColors.color_ababab,
                                  ),
                                  bottom: BorderSide(
                                    width: 2.0,
                                    color: ResourceColors.color_ababab,
                                  )),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  color: ResourceColors.color_dadada,
                                  width: 100.0,
                                  child: Center(
                                    child: Text(
                                      '入札金額',
                                      style: TextStyle(
                                        fontSize: DimenFont.middle,
                                        color: ResourceColors.color_333333,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // color: Colors.black.withOpacity(0.5),
                                  width: 130.0,
                                  child: Text(
                                    "2,000,000円",
                                    textAlign: TextAlign.end, // no impact
                                    style: TextStyle(
                                      fontFamily: "NotoSansJPBlack",
                                      fontSize: DimenFont.large,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Obx(
                            () => Visibility(
                              visible: controller.numberShowDetailBid.value ==
                                  int.parse(itemBidCar!.number!.toString()),
                              child: Container(
                                width: double.maxFinite,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: ResourceColors.color_FFFFFF,
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 2.0,
                                      color: ResourceColors.color_ababab,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      color: ResourceColors.color_dadada,
                                      width: 100.0,
                                      child: Center(
                                        child: Text(
                                          'スタート価格',
                                          style: TextStyle(
                                            fontSize: DimenFont.middle,
                                            color: ResourceColors.color_333333,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 130.0,
                                      child: Text(
                                        "1,000,000円",
                                        textAlign: TextAlign.end, // no impact
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Obx(() => Visibility(
                                visible: controller.numberShowDetailBid.value ==
                                    int.parse(itemBidCar!.number!.toString()),
                                child: Container(
                                  width: double.maxFinite,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: ResourceColors.color_FFFFFF,
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 2.0,
                                        color: ResourceColors.color_ababab,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        color: ResourceColors.color_dadada,
                                        width: 100.0,
                                        child: Center(
                                          child: Text(
                                            '入力金額\n増額金額',
                                            style: TextStyle(
                                              fontSize: DimenFont.middle,
                                              color:
                                                  ResourceColors.color_333333,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 130.0,
                                        child: Text(
                                          '1,800,000円\n200,000円',
                                          textAlign: TextAlign.end, // no impact
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Blur bottom card detail
        // Obx(
        //   () => Visibility(
        //     visible: !controller.expanded.value,
        //     child: Container(
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(6.0),
        //         gradient: LinearGradient(
        //             begin: FractionalOffset.topCenter,
        //             end: FractionalOffset.bottomCenter,
        //             colors: [
        //               ResourceColors.color_f7f7f7.withOpacity(0.5),
        //               ResourceColors.color_f7f7f7,
        //             ],
        //             stops: [
        //               0.2,
        //               0.5,
        //             ]),
        //       ),
        //       height: 22,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // Table 2 car when show full
  Widget _buildBidCarDetailsTable2() {
    return AnimatedContainer(
      duration: new Duration(milliseconds: 700),
      height: controller.numberShowDetailBid.value ==
              int.parse(itemBidCar!.number!.toString())
          ? controller.expandedbid
          : 0,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Column(
            children: [
              Container(
                width: double.maxFinite,
                color: ResourceColors.color_f7f7f7,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 50,
                        decoration: BoxDecoration(
                          color: ResourceColors.color_FFFFFF,
                          border: Border(
                              top: BorderSide(
                                width: 3.0,
                                color: ResourceColors.color_ababab,
                              ),
                              bottom: BorderSide(
                                width: 2.0,
                                color: ResourceColors.color_ababab,
                              )),
                        ),
                        child: Row(
                          children: [
                            Container(
                              color: ResourceColors.color_dadada,
                              width: 100.0,
                              child: Center(
                                child: Text(
                                  '変更・取消',
                                  style: TextStyle(
                                    fontSize: DimenFont.middle,
                                    color: ResourceColors.color_333333,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                width: 245,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                ),
                                height: 35,
                                decoration: BoxDecoration(
                                  color: ResourceColors.color_f53414,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ResourceColors.color_b22008,
                                      blurRadius: 0.5,
                                      offset: Offset(2, 4), // Shadow position
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, //Center Row contents horizontally,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/rollback_ic.svg',
                                      height: 20.0,
                                    ),
                                    SizedBox(width: 7.0),
                                    Text(
                                      '金額変更・入札取消',
                                      style: TextStyle(
                                        fontSize: DimenFont.sp12,
                                        fontFamily: "NotoSansJPRegular",
                                        color: ResourceColors.color_FFFFFF,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 70,
                        decoration: BoxDecoration(
                          color: ResourceColors.color_FFFFFF,
                          border: Border(
                            bottom: BorderSide(
                              width: 2.0,
                              color: ResourceColors.color_ababab,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              color: ResourceColors.color_dadada,
                              width: 100.0,
                              child: Center(
                                child: Text(
                                  '陸送手配状況',
                                  style: TextStyle(
                                    fontSize: DimenFont.middle,
                                    color: ResourceColors.color_333333,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start, //Center Row contents horizontally,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "東西海運(株)",
                                        textAlign: TextAlign.end, // no impact
                                      ),
                                      Container(
                                        width: 245,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: ResourceColors.color_f53414,
                                          border: Border.all(
                                              color:
                                                  ResourceColors.color_f53414,
                                              width: 2.0),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  ResourceColors.color_b22008,
                                              blurRadius: 0.5,
                                              offset: Offset(
                                                  2, 4), // Shadow position
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center, //Center Row contents horizontally,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center, //Center Row contents vertically,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/images/rollback_ic.svg',
                                              height: 20.0,
                                            ),
                                            SizedBox(width: 7.0),
                                            Text(
                                              '金額変更・入札取消',
                                              style: TextStyle(
                                                fontSize: DimenFont.sp12,
                                                fontFamily: "NotoSansJPRegular",
                                                color:
                                                    ResourceColors.color_FFFFFF,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]))
                          ],
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 50,
                        decoration: BoxDecoration(
                          color: ResourceColors.color_FFFFFF,
                          border: Border(
                              bottom: BorderSide(
                            width: 2.0,
                            color: ResourceColors.color_ababab,
                          )),
                        ),
                        child: Row(
                          children: [
                            Container(
                              color: ResourceColors.color_dadada,
                              width: 100.0,
                              child: Center(
                                child: Text(
                                  '商談受付金額',
                                  style: TextStyle(
                                    fontSize: DimenFont.middle,
                                    color: ResourceColors.color_333333,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 130.0,
                              child: Text(
                                "Test",
                                textAlign: TextAlign.end, // no impact
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 70,
                        decoration: BoxDecoration(
                          color: ResourceColors.color_FFFFFF,
                          border: Border(
                              bottom: BorderSide(
                            width: 3.0,
                            color: ResourceColors.color_ababab,
                          )),
                        ),
                        child: Row(
                          children: [
                            Container(
                              color: ResourceColors.color_dadada,
                              width: 100.0,
                              child: Center(
                                child: Text(
                                  'AAワンプラ \n出品状況',
                                  style: TextStyle(
                                    fontSize: DimenFont.middle,
                                    color: ResourceColors.color_333333,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 130.0,
                              child: Text(
                                "Test",
                                textAlign: TextAlign.end, // no impact
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 7.0),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '搬出期限について',
                              style: TextStyle(
                                fontSize: DimenFont.sp13,
                                fontFamily: "NotoSansJPRegular",
                                color: ResourceColors.color_0e67ed,
                              ),
                            ),
                            SizedBox(width: 7.0),
                            SvgPicture.asset(
                              'assets/images/deadline_link_ic.svg',
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 7.0),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/warning_ic.svg',
                              height: 20.0,
                            ),
                            SizedBox(width: 7.0),
                            Text(
                              'クレーム申告期限にご注意ください',
                              style: TextStyle(
                                fontSize: DimenFont.sp13,
                                fontFamily: "NotoSansJPRegular",
                                color: ResourceColors.color_666666,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Button 詳細の確認・変更
  Widget _buildButtonShow() {
    return Obx(
      () => Visibility(
        visible: controller.numberShowDetailBid.value !=
            int.parse(itemBidCar!.number!.toString()),
        child: Container(
          height: 35,
          width: double.maxFinite,
          child: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ResourceColors.color_FFFFFF,
                      border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: ResourceColors.color_ababab,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ResourceColors.color_f7f7f7,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                          ),
                          border: Border(
                            top: BorderSide(
                              width: 1.0,
                              color: ResourceColors.color_ababab,
                            ),
                            bottom: BorderSide(
                              width: 1.0,
                              color: ResourceColors.color_ababab,
                            ),
                            left: BorderSide(
                              width: 1.0,
                              color: ResourceColors.color_ababab,
                            ),
                            right: BorderSide(
                              width: 1.0,
                              color: ResourceColors.color_ababab,
                            ),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            controller.setExpandStatusBid(
                                !controller.expanded.value,
                                int.parse(itemBidCar!.number!.toString()),
                                320);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 1.0),
                                    child: SvgPicture.asset(
                                      'assets/images/show_down_ic.svg',
                                      height: 20.0,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text("詳細の確認・変更"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 2, right: 2),
                        child: Divider(
                          height: 2,
                          thickness: 2,
                          color: ResourceColors.color_f7f7f7,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ResourceColors.color_FFFFFF,
                      border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: ResourceColors.color_ababab,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Button 詳細を隠す
  Widget _buildButtonClose() {
    return Obx(
      () => Visibility(
        visible: controller.numberShowDetailBid.value ==
            int.parse(itemBidCar!.number!.toString()),
        child: Container(
          height: 35,
          width: double.maxFinite,
          child: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ResourceColors.color_f7f7f7,
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: ResourceColors.color_ababab,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ResourceColors.color_FFFFFF,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            topLeft: Radius.circular(8.0),
                          ),
                          border: Border(
                            top: BorderSide(
                              width: 1.0,
                              color: ResourceColors.color_ababab,
                            ),
                            bottom: BorderSide(
                              width: 1.0,
                              color: ResourceColors.color_ababab,
                            ),
                            left: BorderSide(
                              width: 1.0,
                              color: ResourceColors.color_ababab,
                            ),
                            right: BorderSide(
                              width: 1.0,
                              color: ResourceColors.color_ababab,
                            ),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            controller.setExpandStatusBid(
                                !controller.expanded.value, 0, 0);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 1.0),
                                    child: SvgPicture.asset(
                                      'assets/images/show_up_ic.svg',
                                      height: 20.0,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text("詳細を隠す"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 2, right: 2),
                        child: Divider(
                          height: 2,
                          thickness: 2,
                          color: ResourceColors.color_f7f7f7,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ResourceColors.color_f7f7f7,
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: ResourceColors.color_ababab,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header Divider
  Widget _buildHeaderDivider() {
    return Container(
      child: Divider(
        height: 1,
        thickness: 3,
        color: ResourceColors.color_727272,
      ),
    );
  }

  // Serial number of the vehicle
  Widget _buildNumberCar() {
    return Container(
      width: 19.0, //19.0.dimension(),
      height: 19.0, //19.0.dimension(),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFababab)),
          color: ResourceColors.color_FFFFFF,
          shape: BoxShape.rectangle),
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Center(
          child: Text(
            itemBidCar!.number!.toString(),
            style: TextStyle(
              color: ResourceColors.color_black_7,
              fontSize: 12.0, //ScreenUtil.getInstance().getSp(12),
            ),
          ),
        ),
      ),
    );
  }

  // Build  location 会場名
  Text _buildNormalText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: DimenFont.sp12,
        fontFamily: "NotoSansJPRegular",
      ),
    );
  }
}
