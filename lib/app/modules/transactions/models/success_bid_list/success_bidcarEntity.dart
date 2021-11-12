import 'package:flutter_my_page/app/modules/transactions/models/success_bid_list/item_success_bidcar.dart';
import 'package:flutter_my_page/generated/json/base/json_convert_content.dart';
import 'package:json_annotation/json_annotation.dart';

class SuccessBidCarEntity with JsonConvert<SuccessBidCarEntity> {
  List<ItemSuccessBidCar>? data;
  SuccessBidCarEntity([this.data]);
}
