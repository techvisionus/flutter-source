/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-30 08:56:41
 * @LastEditors: saphir
 * @LastEditTime: 2021-06-11 08:41:24
 */
import 'package:flutter_my_page/app/modules/home/models/item_notifi.dart';
import 'package:flutter_my_page/app/modules/home/models/notifyEntity.dart';
import 'package:flutter_my_page/app/modules/home/service/api.dart';
import 'package:flutter_my_page/app/utils/network/async_task.dart';
import 'package:flutter_my_page/app/utils/network/http_utils.dart';
import 'package:flutter_my_page/app/utils/sp_utils/sp_utils.dart';

class HomeService {
  static Future<ResultEntity<NotifyEntity>> getNotices() {
    String token = SpUtils.get<String>('AccessToken', initValue: "");
    Map<String, String> _JSON_HEADERS = {"Authorization": "Bearer ${token}"};
    return HttpUtils().get<NotifyEntity>(HomeApi.NotifiEndpoint,
        options: (Options(headers: _JSON_HEADERS)));
  }
}

class Controller {}
