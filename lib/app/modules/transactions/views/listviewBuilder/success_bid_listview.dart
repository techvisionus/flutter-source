import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/modules/transactions/controllers/transactions_controller.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:flutter_my_page/app/widget/dot_widget.dart';
import 'package:flutter_my_page/app/widget/running_text_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_my_page/app/modules/transactions/models/bid_list/item_bidcar.dart';

class SuccessBidListView extends GetView<TransactionsController> {
  final ItemBidCar? itemBidCar;
  SuccessBidListView(this.itemBidCar);
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
            height: controller.numberShowDetailSuccess.value !=
                    int.parse(itemBidCar!.number!.toString())
                ? 180
                : 230,
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
                              visible:
                                  controller.numberShowDetailSuccess.value ==
                                      int.parse(itemBidCar!.number!.toString()),
                              child: Container(
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        '10月6日開催',
                                        style: TextStyle(
                                          fontSize: DimenFont.sp12,
                                          fontFamily: "NotoSansJPRegular",
                                          color: ResourceColors.color_333333,
                                        ),
                                      ),
                                    ),
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
                          // Trademark
                          Text(
                            'トヨタ',
                            style: TextStyle(
                              fontSize: DimenFont.sp14,
                              fontFamily: "NotoSansJPRegular",
                              color: ResourceColors.color_333333,
                            ),
                          ),
                          // Car name
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
                          Row(
                            children: [
                              Text('車台番号：',
                                  style: TextStyle(
                                    fontSize: DimenFont.sp12,
                                    fontFamily: "NotoSansJPRegular",
                                    color: ResourceColors.color_333333,
                                  )),
                              Text('EXD77AG-7000083',
                                  style: TextStyle(
                                    fontSize: DimenFont.sp12,
                                    fontFamily: "NotoSansJPRegular",
                                    color: ResourceColors.color_333333,
                                  ))
                            ],
                          ),
                          SizedBox(height: 5.0),
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
                                Container(
                                  width: 90,
                                  height: 22,
                                  decoration: BoxDecoration(
                                      color: ResourceColors.color_b80707,
                                      border: Border.all(
                                          color: ResourceColors.color_b80707,
                                          width: 2.0),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      '落札日',
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
                                    '2021年9月1日',
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

                          SizedBox(height: 15.0),
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
                                      '落札金額',
                                      style: TextStyle(
                                        fontSize: DimenFont.middle,
                                        color: ResourceColors.color_333333,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // color: Colors.black.withOpacity(0.5),
                                  width: 140.0,
                                  child: Text("5,550,000円",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: DimenFont.large,
                                        fontFamily: "NotoSansJPBlack",
                                      ) // no impact
                                      ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Table 2 car when show full
  Widget _buildBidCarDetailsTable2() {
    return AnimatedContainer(
      duration: new Duration(milliseconds: 700),
      height: controller.numberShowDetailSuccess.value ==
              int.parse(itemBidCar!.number!.toString())
          ? controller.expandedsuccessbid
          : 0,
      child:
          ListView(physics: NeverScrollableScrollPhysics(), children: <Widget>[
        Column(
          children: [
            Container(
              height: 300,
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
                                '陸送手配状況',
                                style: TextStyle(
                                  fontSize: DimenFont.middle,
                                  color: ResourceColors.color_333333,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Text('東西海運(株)'),
                          ),
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
                              padding: EdgeInsets.only(top: 5.0),
                              color: ResourceColors.color_dadada,
                              width: 100.0,
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      '入金状況',
                                      style: TextStyle(
                                        fontSize: DimenFont.sp14,
                                        color: ResourceColors.color_333333,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      '(計算書プレビュー)',
                                      style: TextStyle(
                                        fontSize: DimenFont.sp10,
                                        color: ResourceColors.color_333333,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            width: 130.0,
                            child: Text(
                              "",
                              textAlign: TextAlign.end, // no impact
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 80,
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
                                'クレーム申告 \n物品未着問合\n せ / クレーム\n 期限延長',
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 245,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: ResourceColors.color_f53414,
                                    border: Border.all(
                                        color: ResourceColors.color_f53414,
                                        width: 2.0),
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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center, //Center Row contents vertically,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/play_ic.svg',
                                        height: 20.0,
                                      ),
                                      SizedBox(width: 7.0),
                                      Text(
                                        'クレーム申告',
                                        style: TextStyle(
                                          fontSize: DimenFont.sp12,
                                          fontFamily: "NotoSansJPRegular",
                                          color: ResourceColors.color_FFFFFF,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 30,
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
                                'クレーム状況',
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
                              "",
                              textAlign: TextAlign.end, // no impact
                            ),
                          )
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
                                '書類・物品発\n送状況',
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
                              "",
                              textAlign: TextAlign.end, // no impact
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 30,
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
                                '名義変更',
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
                              "",
                              textAlign: TextAlign.end, // no impact
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 7.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  // Button 詳細の確認・変更
  Widget _buildButtonShow() {
    return Obx(
      () => Visibility(
        visible: controller.numberShowDetailSuccess.value !=
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
                            controller.setExpandStatusSuccessBid(
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
                                    child: Text("詳細の確認"),
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
        visible: controller.numberShowDetailSuccess.value ==
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
                            controller.setExpandStatusSuccessBid(
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
