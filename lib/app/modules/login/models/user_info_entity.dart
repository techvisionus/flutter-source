/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-29 15:42:27
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-07 09:41:39
 */
import 'package:flutter_my_page/generated/json/base/json_convert_content.dart';

class UserInfoEntity with JsonConvert<UserInfoEntity> {
  String? accessToken;
  String? phone;
  String? username;
  String? avatar;
  String? id;
}
