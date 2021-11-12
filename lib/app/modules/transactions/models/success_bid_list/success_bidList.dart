/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-29 15:42:27
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-07 09:41:39
 */
import 'package:flutter_my_page/app/modules/transactions/models/success_bid_list/item_success_bidlist.dart';
import 'package:flutter_my_page/generated/json/base/json_convert_content.dart';

class SuccessBidListEntity with JsonConvert<SuccessBidListEntity> {
  List<ItemSuccessBidList>? listItemSuccessBidList;
  SuccessBidListEntity([this.listItemSuccessBidList]);
}
