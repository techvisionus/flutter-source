/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-19 16:10:54
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-12 16:25:18
 */
import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/config/constants.dart';
import 'package:flutter_my_page/app/plugins/options/options.dart';
import 'package:flutter_my_page/app/utils/sp_utils/sp_utils.dart';
import 'package:flutter_my_page/my_app.dart';
import 'package:statsfl/statsfl.dart';

void main() async {
  await initApp(Environment.dev);
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
    child: MyApp(
      environment: Environment.dev,
      baseUrl: devBaseUrl,
    ),
  ));
}
