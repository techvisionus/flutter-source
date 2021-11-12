/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-29 15:42:27
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-07 09:41:39
 */
import 'package:flutter_my_page/app/modules/transactions/models/bid_list/item_bidlist.dart';
import 'package:flutter_my_page/generated/json/base/json_convert_content.dart';

class BidListEntity with JsonConvert<BidListEntity> {
  List<ItemBidList>? listItemBidList;
  BidListEntity([this.listItemBidList]);
}
