/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-19 16:10:54
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-18 09:40:49
 */
import 'package:flutter_my_page/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_my_page/app/modules/home/views/home_page.dart';
import 'package:flutter_my_page/app/modules/index/bindings/index_binding.dart';
import 'package:flutter_my_page/app/modules/index/views/index_page.dart';
import 'package:flutter_my_page/app/routes/404.dart';
import 'package:flutter_my_page/app/routes/feature_routes.dart';
import 'package:flutter_my_page/app/routes/home_route.dart';
import 'package:flutter_my_page/app/routes/login_route.dart';
import 'package:flutter_my_page/app/routes/mine_route.dart';
import 'package:get/get.dart';

class AppRoutes {
  ///main page
  static final String main = "/main";

  ///Global webview
  static final String webView = "/webView";

  ///View the picture page
  static final String photoViewPage = "/photoViewPage";

  static final List<GetPage> allPages = []
    ..add(
      GetPage(name: main, page: () => IndexPage(), binding: IndexBinding()),
    )
    ..addAll(FeaturesRoute.pages)
    ..addAll(MineRoute.pages)
    ..addAll(LoginRoute.pages);

  static GetPage getNotFoundPage() {
    return GetPage(name: '/notfound', page: () => NotFoundPage());
  }
}
