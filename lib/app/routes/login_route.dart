/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-05-18 09:34:08
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-18 09:36:00
 */
import 'package:flutter_my_page/app/modules/login/bindings/login_binding.dart';
import 'package:flutter_my_page/app/modules/login/views/login_page.dart';
import 'package:get/get.dart';

class LoginRoute {
  static String login = '/login';

  static final pages = [
    GetPage(name: login, page: () => LoginPage(), binding: LoginBinding())
  ];
}
