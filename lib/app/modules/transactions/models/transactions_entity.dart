import 'package:flutter_my_page/app/modules/transactions/models/bid_list/bidList.dart';
import 'package:flutter_my_page/app/modules/transactions/models/bid_list/item_bidcar.dart';
import 'package:flutter_my_page/app/modules/transactions/models/success_bid_list/success_bidList.dart';
import 'package:flutter_my_page/app/modules/transactions/models/success_bid_list/success_bidcarEntity.dart';
import 'package:flutter_my_page/generated/json/base/json_convert_content.dart';
import 'package:flutter_my_page/app/modules/transactions/models/bid_list/bidcarEntity.dart';
import 'package:get/get.dart';

class TransactionsEntity with JsonConvert<TransactionsEntity> {
  Rx<String> loginNumber = "".obs;
  Rx<String> loginName = "".obs;
  BidCarEntity? bidCarEntity;
  BidListEntity? bidListEntity;

  SuccessBidCarEntity? successbidCarEntity;
  SuccessBidListEntity? successbidListEntity;

  TransactionsEntity([this.bidCarEntity]);
}
