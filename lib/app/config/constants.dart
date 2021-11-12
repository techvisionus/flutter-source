/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-27 16:34:54
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-05 14:15:29
 */
import 'package:flustars/flustars.dart';
import 'package:flutter_my_page/app/plugins/options/options.dart';
import 'package:logging/logging.dart';
import 'package:get/get.dart';

Environment environment = Environment.dev;
String baseUrl = "http://192.168.200.101:8082";
String devBaseUrl = 'http://192.168.200.101:8082';
String testBaseUrl = 'https://612d192be579e1001791daba.mockapi.io';
String preBaseUrl = 'http://192.168.200.101:8082';
// logger configuration
Level loggerLevel = environment == Environment.prod ? Level.OFF : Level.ALL;
// Debug mode
bool isTest = environment == Environment.test ? true : false;
bool isDev = environment == Environment.dev ? true : false;

//-----------------list configuration------------------
int pageSize = 10; //Number of page
int pageNum = 1; //First page of list

// Title in bottom bar
// ignore: non_constant_identifier_names
var BOTTOM_TITLE_LIST = [
  "NOTICE_TITLE".tr,
  "TRANSACTIONS".tr,
  "CHARGE_DETAIL".tr,
  "PROFILE".tr,
];

const String COUNT_NOTI_FIREBASE = 'countReceivedNotifi';
const SCREEN = 'screen';
const NOTICE = 'NOTICE';
const BADGE_DEFAULT = 0;
const FCM_TOKEN_VALUE = 'FCMTokenValue';
const FCM_TOKEN = "fcmToken";
const ACCESS_TOKEN = 'AccessToken';
const AUTHORIZATION = "Authorization";


//-----------------list constraint------------------
const double kDrawIconWidth = 25.0;
const double kDrawNoticeIconWidth = 27.0;
const double kDrawOpenASNETIconWidth = 20.0;
const double kBottomNavIconSize = 30.0;
const double kBottomNavNoticeIconSize = 35.0;
