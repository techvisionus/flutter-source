/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-26 10:21:37
 * @LastEditors: saphir
 * @LastEditTime: 2021-04-29 16:24:55
 */
import 'package:flutter_my_page/app/utils/network/task_type.dart';

abstract class NetWorkCallback {
  void onNetWorkCallback(TaskResult result, String msg, Map? response,
      Map<String, dynamic>? extraData);
}

abstract class NetWorkCacheCallback {
  void onCacheCallBack(bool dataFromCache);
}
