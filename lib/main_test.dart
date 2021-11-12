/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-19 16:10:54
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-12 15:55:28
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_my_page/app/common/firebase/push_notification_helper.dart';
import 'package:flutter_my_page/app/config/constants.dart';
import 'package:flutter_my_page/app/plugins/options/options.dart';
import 'package:flutter_my_page/app/utils/sp_utils/sp_utils.dart';
import 'package:flutter_my_page/my_app.dart';
import 'package:statsfl/statsfl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_my_page/app/common/firebase/firebase_message_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessageHelper.instance().firebaseConfig();

  // onBackgroundMessage is only Work at MainApp
  handlePushInBackground();

  // Check if device support badge or not
  try {
    bool res = await FlutterAppBadger.isAppBadgeSupported();
    if (res) {
      print('Supported');
    } else {
      print('Not Supported');
    }
  } on PlatformException {
    print('Failed to get badge support.');
  }

  await initApp(Environment.test);
  //sp init
  await SpUtils.init();
  runApp(StatsFl(
    isEnabled: false, //Toggle on/off
    width: 80, //Set size
    height: 30, //
    maxFps: 90, // Support custom FPS target (default is 60)
    // showText: true, // Hide text label
    sampleTime: .5, //Interval between fps calculations, in seconds.
    totalTime: 15, //Total length of timeline, in seconds.
    align: Alignment.centerRight,
    child: MyApp(environment: Environment.test),
  ));
}

void handlePushInBackground() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessageBackground);
}

Future<void> _firebaseMessageBackground(RemoteMessage message) async {
  print("Handling a Background Message");
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  print("Handling a Foreground Message");
  print("onMessage: $message");

  // Count numbers Notification Received from FireBase
  countNotificationFireBase();
  // // Handle Show Notification Icon App from FireBase
  // if (SpUtils.get('isLogin') == true) {
  //   handleShowNotificationBadge();
  // }

  //showNotification(notification?.title, notification?.body);
}

// void showNotification(String? title, String? body) {
//   try {
//     PushNotificationHelper.instance().showNotification(title, body);
//   } catch (ex) {
//     print('Error: ' + ex.toString());
//   }
// }

void subscribeToTopic() async {
  try {
    await FirebaseMessaging.instance.subscribeToTopic('news');
    print('subscribed to topic');
  } catch (e) {
    print('error is $e');
  }
}

void countNotificationFireBase() {
  int value = SpUtils.get(COUNT_NOTI_FIREBASE, initValue: 0);
  print(value);
  SpUtils.put(COUNT_NOTI_FIREBASE, value + 1);

  updateBadgeApp();
}

updateBadgeApp() {
  FlutterAppBadger.updateBadgeCount(getTotalNotificationFireBase());
}

int getTotalNotificationFireBase() {
  int value = SpUtils.get(COUNT_NOTI_FIREBASE, initValue: 0);
  return value;
}
