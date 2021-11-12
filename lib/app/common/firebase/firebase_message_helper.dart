import 'package:flutter_my_page/app/common/firebase/push_notification_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_my_page/app/config/constants.dart';
import 'package:flutter_my_page/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_my_page/app/modules/index/controllers/index_controller.dart';
import 'package:flutter_my_page/app/routes/app_routes.dart';
import 'package:flutter_my_page/app/routes/login_route.dart';
import 'package:flutter_my_page/app/routes/utils/get_navigator.dart';
import 'package:flutter_my_page/app/utils/sp_utils/sp_utils.dart';
import 'package:get/get.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

class FirebaseMessageHelper {
  static FirebaseMessageHelper _singleton = FirebaseMessageHelper._internal();

  factory FirebaseMessageHelper() {
    return _singleton;
  }

  FirebaseMessageHelper._internal();

  static FirebaseMessageHelper instance() {
    if (_singleton == null) {
      _singleton = FirebaseMessageHelper._internal();
    }
    return _singleton;
  }

  void firebaseConfig() async {
    // Setup for Show alert when receive Message from FireBase
    setupShowAlertFireBase();
    handleNotificationForeground();
    handleAfterOpenedApp();
  }

  void setupShowAlertFireBase() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

   Future getFcmToken()async{
    return FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print("FCM token: ${token ?? ""}");
      SpUtils.put(FCM_TOKEN_VALUE, token);
    });
  }

  void handleNotificationForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Handling a Foreground Message");
      print("onMessage: $message");

      // Count numbers Notification Received from FireBase
      countNotificationFireBase();
      // Handle Show Notification Icon App from FireBase
      if (SpUtils.get('isLogin') == true) {
        handleShowNotificationBadge();
      }

      RemoteNotification? notification = message.notification;
      showNotification(notification?.title, notification?.body);
    });
  }

  handleShowNotificationBadge() {
    var indexController = Get.find<IndexController>();
    int totalNotiFireBase = getTotalNotificationFireBase();

    // Show Icon Menu
    showIconMenu(indexController, totalNotiFireBase);

    // Show numbers Notification to NotificationIcon from FireBase
    indexController.notiCount.value = totalNotiFireBase;
    indexController.countNofiFireBase.value = totalNotiFireBase;
  }

  showIconMenu(IndexController indexController, int numbersNotiFireBase) {
    if (numbersNotiFireBase == 0) {
      indexController.isShowNotiMenu.value = false;
    } else {
      indexController.isShowNotiMenu.value = true;
    }
  }

  void countNotificationFireBase() {
    int value = SpUtils.get(COUNT_NOTI_FIREBASE, initValue: 0);
    print(value);
    SpUtils.put(COUNT_NOTI_FIREBASE, value + 1);

    updateBadgeApp();
  }

  //Update Badge For Icon App
  updateBadgeApp() {
    FlutterAppBadger.updateBadgeCount(getTotalNotificationFireBase());
  }

  int getTotalNotificationFireBase() {
    int value = SpUtils.get(COUNT_NOTI_FIREBASE, initValue: 0);
    return value;
  }

  bool hasNotificationFireBase() {
    int value = SpUtils.get(COUNT_NOTI_FIREBASE, initValue: 0);
    if (value == 0) {
      return false;
    } else {
      return true;
    }
  }

  void handleAfterOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');

      // Count Notification Received from FireBase
      countNotificationFireBase();

      if (SpUtils.get('isLogin') == false) {
        NavigatorUtils.offNamed(LoginRoute.login);
      } else {
        navigationScreen(message);
        handleShowNotificationBadge();
      }
    });
  }

  void navigationScreen(RemoteMessage message) {
    try {
      String screen = message.data[SCREEN];
      if (screen == NOTICE) {
        navigationNotificationHome();
      }
    } catch (e) {}
  }

  void navigationNotificationHome() {
    //NavigatorUtils.offNamed(AppRoutes.main);
    var controller = Get.find<IndexController>();
    controller.tabIndex.value = 0;
    controller.title.value = BOTTOM_TITLE_LIST[0];
    controller.pageController?.jumpToPage(0);
    var indexController = Get.find<HomeController>();
    indexController.tabController?.animateTo(0);
  }

  void showNotification(String? title, String? body) {
    try {
      PushNotificationHelper.instance().showNotification(title, body);
    } catch (ex) {
      print('Error: ' + ex.toString());
    }
  }
}
