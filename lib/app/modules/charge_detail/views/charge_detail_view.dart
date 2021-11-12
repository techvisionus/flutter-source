/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-20 09:21:53
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-08 17:35:08
 */
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';

import 'package:get/get.dart';

import '../controllers/charge_detail_controller.dart';

class ChargeDetailPage extends GetView<ChargeDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'DEVELOPING'.tr,
          style: TextStyle(
            fontSize: DimenFont.sp40,
            fontFamily: "NotoSansJPBold",
          ),
        ),
      ),
    );
  }
}
