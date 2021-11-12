/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-19 16:10:54
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-13 08:26:41
 */
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/common/firebase/firebase_message_helper.dart';
import 'package:flutter_my_page/app/config/constants.dart';
import 'package:flutter_my_page/my_app.dart';
import 'app/plugins/options/options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessageHelper.instance().firebaseConfig();

  FirebaseMessaging.instance.getToken().then((value) {
    String? token = value;
    print("FCM token: ${token ?? ""}");
  });

  // onBackgroundMessage is only Work at MainApp
  handlePushInBackground();

  // Update Badger App
  // FirebaseMessageHelper.instance().updateBadgeApp();

  await initApp(Environment.prod);
  runApp(MyApp(baseUrl: baseUrl));
}

void handlePushInBackground() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessageBackground);
}

Future<void> _firebaseMessageBackground(RemoteMessage message) async {
  print("Handling a Background Message");
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
}

void subscribeToTopic() async {
  try {
    await FirebaseMessaging.instance.subscribeToTopic('news');
    print('subscribed to topic');
  } catch (e) {
    print('error is $e');
  }
}
