/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-30 08:56:41
 * @LastEditors: saphir
 * @LastEditTime: 2021-06-11 08:41:24
 */
import 'package:flutter_my_page/app/config/constants.dart';
import 'package:flutter_my_page/app/modules/login/models/user_info_entity.dart';
import 'package:flutter_my_page/app/modules/login/service/api.dart';
import 'package:flutter_my_page/app/utils/network/async_task.dart';
import 'package:flutter_my_page/app/utils/network/http_utils.dart';
import 'package:flutter_my_page/app/utils/sp_utils/sp_utils.dart';

class LoginService {
  static Future<ResultEntity<UserInfoEntity>> login(username, password) {
    var params = {"memberNum": username, "passValue": password};
    return HttpUtils()
        .post<UserInfoEntity>(LoginApi.loginEndpoint, param: params);
  }

  static Future<ResultEntity<UserInfoEntity>> pushFcmToken() {
    String fcmToken = SpUtils.get<String>(FCM_TOKEN_VALUE, initValue: "");
    var params = {FCM_TOKEN: fcmToken};
    String token = SpUtils.get<String>(ACCESS_TOKEN, initValue: "");
    Map<String, String> _JSON_HEADERS = {AUTHORIZATION: "Bearer ${token}"};
    return HttpUtils().post<UserInfoEntity>(LoginApi.tokenFireBaseEndpoint,
        param: params, options: (Options(headers: _JSON_HEADERS)));
  }
}
