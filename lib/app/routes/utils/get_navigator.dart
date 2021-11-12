/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-08 18:09:36
 * @LastEditors: saphir
 * @LastEditTime: 2021-04-27 16:17:52
 */
import 'package:flutter_my_page/app/routes/app_routes.dart';
import 'package:get/get.dart';

class NavigatorUtils {
  //Navigate to the next page
  static push(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    return Get.toNamed(page,
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters);
  }

  //Browse and delete the previous page
  static offNamed(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    Get.offNamed(page,
        arguments: arguments,
        id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters);
  }

  //Browse and delete all previous pages.
  static offAllNamed(String page) {
    Get.offAllNamed(page);
  }

  //Close SnackBars, Dialogs, BottomSheets, or anything you would normally close with Navigator.pop(context)
  static goBack<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) {
    Get.back(
        result: result, closeOverlays: closeOverlays, canPop: canPop, id: id);
  }

  static pushToWebView(String title, String url) {
    push(AppRoutes.webView, parameters: {"title": title, "url": url});
  }

  // static pushToPhotoViewPage(List<String> path, [int? index]) {
  //   if (path.isNotEmpty) {
  //     push(RouteConfig.photoViewPage, arguments: PhotoViewModel(path, index));
  //   }
  // }

  static void pushToRoot() {
    Get.offNamedUntil(AppRoutes.main, (route) {
      return route.isFirst;
    });
  }
}

class PhotoViewModel {
  List<String> path;
  int index;

  PhotoViewModel(this.path, this.index);
}
