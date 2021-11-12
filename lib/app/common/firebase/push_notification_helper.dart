import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_my_page/app/config/constants.dart';
import 'package:flutter_my_page/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_my_page/app/modules/index/controllers/index_controller.dart';
import 'package:get/get.dart';

class PushNotificationHelper {
  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static PushNotificationHelper _singleton = PushNotificationHelper._internal();

  factory PushNotificationHelper() {
    return _singleton;
  }

  void selectNotification(String? payload) async {
    var controller = Get.find<IndexController>();
    controller.tabIndex.value = 0;
    controller.title.value = BOTTOM_TITLE_LIST[0];
    controller.pageController?.jumpToPage(0);
    var indexController = Get.find<HomeController>();
    indexController.tabController?.animateTo(0);
  }

  void onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {}

  PushNotificationHelper._internal();

  static PushNotificationHelper instance() {
    if (_singleton == null) {
      _singleton = PushNotificationHelper._internal();
    }
    return _singleton;
  }

  Future<void> showNotification(String? title, String? body) async {
    /// Create a [AndroidNotificationChannel] for heads up notifications
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );
    var androidPlatformNotificationDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      color: Colors.blue,
      playSound: true,
      icon: '@mipmap/ic_launcher',
    );

    var iOSPlatformNotificationDetails = IOSNotificationDetails();

    configNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
          android: androidPlatformNotificationDetails,
          iOS: iOSPlatformNotificationDetails),
    );
  }

  // Config Create a Notification Channel for receive Message from FireBase
  void configNotificationChannel(AndroidNotificationChannel channel) async {
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .createNotificationChannel(channel);
    }

    if (Platform.isIOS) {
      String? token = await FirebaseMessaging.instance.getAPNSToken();
      print('FlutterFire Messaging Example: Got APNs token: $token');
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()!
          .requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }
}
