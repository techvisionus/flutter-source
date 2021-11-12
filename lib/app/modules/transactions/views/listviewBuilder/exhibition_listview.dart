import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/modules/transactions/controllers/transactions_controller.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:flutter_my_page/app/widget/floating_button_widget.dart';
import 'package:flutter_my_page/app/widget/running_text_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_my_page/app/widget/dot_widget.dart';
import 'package:flutter_my_page/app/modules/transactions/models/bid_list/item_bidcar.dart';

class ExhibitionListView extends GetView<TransactionsController> {
  final ItemBidCar? itemBidCar;
  ExhibitionListView(this.itemBidCar);
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
              ],
            ),
          ),
          // Serial number of the vehicle
          _buildNumberCar(),
          Positioned(
            top: 25,
            left: 1,
            child: Stack(
              children: <Widget>[
                Container(
                  child: SvgPicture.asset(
                    'assets/images/label_ic.svg',
                    height: 24.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Text('商談',
                      style: TextStyle(
                        fontSize: DimenFont.sp13,
                        fontWeight: FontWeight.w200,
                        color: ResourceColors.color_FFFFFF,
                        fontFamily: "NotoSansJPRegular",
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Table 1 detail car when show part
  Widget _buildBidCarDetailsTable1() {
    return Container(
      height: 230,
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
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 1.0),
                          child: SvgPicture.asset(
                            'assets/images/store_ic.svg',
                            height: 15.0,
                          ),
                        ),
                        SizedBox(width: 1.5),
                        Text(
                          'エーエス自動',
                          style: TextStyle(
                            fontSize: DimenFont.sp12,
                            fontWeight: FontWeight.w800,
                            fontFamily: "NotoSansJPRegular",
                          ),
                        )
                      ],
                    ),
                    Text(
                      '車 福岡店',
                      style: TextStyle(
                        fontSize: DimenFont.sp12,
                        fontWeight: FontWeight.w800,
                        fontFamily: "NotoSansJPRegular",
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      width: 90,
                      height: 25,
                      color: ResourceColors.color_333333,
                      child: Center(
                        child: Text(
                          '管理番号',
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
                          '00100037',
                          style: TextStyle(
                            fontSize: DimenFont.sp12,
                            fontFamily: "NotoSansJPRegular",
                            color: ResourceColors.color_333333,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 1.0),
                          child: SvgPicture.asset(
                            'assets/images/view_ic.svg',
                            height: 10.0,
                          ),
                        ),
                        SizedBox(width: 3.0),
                        Text(
                          '2,584',
                          style: TextStyle(
                            fontSize: DimenFont.sp12,
                            fontWeight: FontWeight.w800,
                            fontFamily: "NotoSansJPRegular",
                          ),
                        )
                      ],
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
                            ? _buildNormalText(itemBidCar!.species!.toString())
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
                                color: ResourceColors.color_555555,
                                border: Border.all(
                                    color: ResourceColors.color_555555,
                                    width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Text(
                                '更新日 ',
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
                                '出品価格',
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
                    SizedBox(height: 5.0),

                    FloatingButtonWidget(
                      textCenter: '編集はこちら',
                      imgCenter: 'assets/images/edit_ic.svg',
                      imgRight: 'assets/images/picture_click_ic.svg',
                    ),

                    // Container(
                    //   width: double.maxFinite,
                    //   height: 40,
                    //   decoration: BoxDecoration(
                    //     color: ResourceColors.color_0f875c,
                    //     border: Border.all(
                    //         color: ResourceColors.color_0f875c, width: 2.0),
                    //     borderRadius: BorderRadius.all(
                    //       Radius.circular(5),
                    //     ),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: ResourceColors.color_074d34,
                    //         blurRadius: 1,
                    //         offset: Offset(2, 4), // Shadow position
                    //       ),
                    //     ],
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment
                    //         .center, //Center Row contents horizontally,
                    //     crossAxisAlignment: CrossAxisAlignment
                    //         .center, //Center Row contents vertically,
                    //     children: [
                    //       SvgPicture.asset(
                    //         'assets/images/edit_ic.svg',
                    //         height: 20.0,
                    //       ),
                    //       SizedBox(width: 7.0),
                    //       Text(
                    //         '編集はこちら',
                    //         style: TextStyle(
                    //           fontSize: DimenFont.sp15,
                    //           fontFamily: "NotoSansJPRegular",
                    //           color: ResourceColors.color_FFFFFF,
                    //         ),
                    //       ),
                    //       SizedBox(width: 30.0),
                    //       SvgPicture.asset(
                    //         'assets/images/picture_click_ic.svg',
                    //         height: 20.0,
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ],
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
