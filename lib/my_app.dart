/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-05-12 15:49:52
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-27 11:47:56
 */
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_my_page/app/routes/login_route.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app/config/application.dart';
import 'app/config/constants.dart';
import 'app/lang/translation_service.dart';
import 'app/plugins/options/options.dart';
import 'app/plugins/options/scales.dart';
import 'app/plugins/options/themes.dart';
import 'app/routes/app_routes.dart';
import 'app/utils/log/log.dart';
import 'app/utils/network/http_utils.dart';
import 'app/utils/sp_utils/sp_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

///The method called before runApp
Future<void> initApp(Environment environ) async {
  WidgetsFlutterBinding.ensureInitialized();
  // Force vertical screen
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //sp init
  await SpUtils.init();
  environment = environ;
}

class MyApp extends StatelessWidget {
  AppOptions? options;
  final Environment? environment;
  final String? baseUrl;
  MyApp({
    Key? key,
    this.options,
    this.environment,
    this.baseUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _init(context);
    return GetMaterialApp(
      title: "Techvisonus",
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute: SpUtils.get<bool>('isLogin', initValue: false)
          ? AppRoutes.main
          : LoginRoute.login,
      getPages: AppRoutes.allPages,
      unknownRoute: AppRoutes.getNotFoundPage(),
      // logWriterCallback: LoggerConfig.write,
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      builder: EasyLoading.init(
          builder: (context, child) => GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                child: Directionality(
                    textDirection: AppOptions().textDirection,
                    child: _applyTextScaleFactor(child ?? Container())),
              )),
      routingCallback: (value) {
        Log.info(value?.current);
      },
    );
  }

  void _resetIsLogin() {
    SpUtils.put('isLogin', false);
  }

  void _init(BuildContext context) {
    _resetIsLogin();

    String themeName = SpUtils.get<String>('theme');
    Application.context = context;
    Application.initPackageInfo();
    _initDio();
    var currentTheme = appThemes.firstWhere(
        (element) => (element.name == themeName),
        orElse: () => lightTheme);
    Get.changeTheme(currentTheme.data);
    // _initTheme();
    this.options = AppOptions(
        textScaleFactor: AppTextScaleValue(null, 'System Default'),
        timeDilation: 1.0,
        platform: TargetPlatform.iOS,
        environment: this.environment,
        proxy: 'DIRECT');
    //Set the width and height of the design draft
    setDesignWHD(375, 812);
  }

  void _initDio() {
    HttpUtils().initNetWork(this.baseUrl);
    //Open log
    Log.configuration(loggerLevel);
  }

  /// App font size does not change with system font
  Widget _applyTextScaleFactor(Widget child) {
    return Builder(
      builder: (BuildContext context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: child,
        );
      },
    );
  }
}
