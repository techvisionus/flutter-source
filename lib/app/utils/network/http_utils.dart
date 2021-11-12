/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-03-29 13:51:00
 * @LastEditors: saphir
 * @LastEditTime: 2021-04-29 17:51:53
 */
import 'package:flutter_my_page/app/utils/network/http_util.dart';
import 'package:flutter_my_page/generated/json/base/json_convert_content.dart';

import 'network.dart';

class HttpUtils extends NetWorkHttpUtils {
  static final HttpUtils _instance = HttpUtils._();
  static final String networkBasicId = "ZmFtZXI6ZmFtZXI=";

  HttpUtils._();

  factory HttpUtils() {
    return _instance;
  }

  void initNetWork(String? baseUrl) {
    NetWork().init(baseUrl ?? "api.host", networkBasicId, refreshApi: "",
        refreshErrorCallBack: () {
      // if (Application.context != null) {
      //   Loading.hideLoading(Application.context);
      // }
      // Get.dialog(LogoutMsgDialog());
    });
  }

  @override
  T jsonParseData<T>(responseData) {
    if (T.toString() == "TokenEntity") {
      // return TokenEntity().fromJson(responseData) as T;
    }
    return JsonConvert.fromJsonAsT<T>(responseData);
  }
}
