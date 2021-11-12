import 'package:flutter_my_page/app/modules/transactions/models/bid_list/item_bidcar.dart';
import 'package:flutter_my_page/generated/json/base/json_convert_content.dart';
import 'package:json_annotation/json_annotation.dart';

class BidCarEntity with JsonConvert<BidCarEntity> {
  List<ItemBidCar>? data;
  BidCarEntity([this.data]);
}
