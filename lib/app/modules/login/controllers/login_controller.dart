/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-05-18 09:32:18
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-18 10:17:04
 */

import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/common/firebase/firebase_message_helper.dart';
import 'package:flutter_my_page/app/config/constants.dart';
import 'package:flutter_my_page/app/modules/login/models/user_info_entity.dart';
import 'package:flutter_my_page/app/modules/login/service/login_service.dart';
import 'package:flutter_my_page/app/routes/app_routes.dart';
import 'package:flutter_my_page/app/routes/utils/get_navigator.dart';
import 'package:flutter_my_page/app/utils/log/log.dart';
import 'package:flutter_my_page/app/utils/network/task_type.dart';
import 'package:flutter_my_page/app/utils/sp_utils/sp_utils.dart';
import 'package:get/get.dart';
import 'package:flutter_my_page/app/utils/secure_storage/user_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_my_page/app/widget/dialog/mypage_dialog.dart';

class LoginController extends GetxController with StateMixin<UserInfoEntity> {
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<bool> isToggled = false.obs;
  Rx<bool> isValidate = false.obs;
  final formKey = GlobalKey<FormState>();
  final controllerName = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future init() async {
    SpUtils.get<bool>('isToggled', initValue: false)
        ? getUserinfo()
        : isToggled.value = false;

    if (isDev) {
      if (this.accountController.text == '' &&
          this.passwordController.text == '') {
        this.accountController.text = '88888195';
        this.passwordController.text = '12345678';
      }
    }
  }

  void getUserinfo() async {
    isToggled.value = true;
    UserSecureStorage.getUsername()
        .then((value) => {this.accountController.text = value ?? ''});
    UserSecureStorage.getPassword()
        .then((value) => {this.passwordController.text = value ?? ''});
  }

  clickLogin(BuildContext context) async {
    if (isTest) {
      // DEBUG MODE IS ON
      SpUtils.put('isLogin', true)
          .then((value) => NavigatorUtils.offNamed(AppRoutes.main));
    } else {
      // DEBUG MODE IS OFF
      final account = accountController.text;
      final password = passwordController.text;
      if (validateLogin() == true) {
        callLoginApi(context, account, password);
      } else {
        // show error dialog
        MyPageDialog.showDialog(
            "Error", 'ERROR_LOGIN_VALIDATE_FAILED'.tr, false);
      }
    }
  }

  saveLogin(String account, String password) async {
    await UserSecureStorage.setUsername(account);
    await UserSecureStorage.setPassword(password);
  }

  callLoginApi(BuildContext context, String account, String password) {
    /// show loading indicator
    EasyLoading.show();
    LoginService.login(account, password).then((value) async {
      /// hide loading
      EasyLoading.dismiss();
      switch (value.result) {
        case TaskResult.success:
          await saveLogin(account, password);

          if (value.data != null) {
            // Save access token
            await SpUtils.put('AccessToken', value.data!.accessToken);
            // Get Fcm Token and Call Api to Send it
            getFcmTokenAndCallApi();
            // gotoMainPage
            SpUtils.put('isLogin', true)
                .then((value) => NavigatorUtils.offNamed(AppRoutes.main));
          }
          break;
        default:
          // Case show dialog cant connect to server
          if (value.messageData == null) {
            MyPageDialog.showDialog(
                "Error", 'ERROR_SYSTEM_EXCEPTION'.tr, false);
          } else {
            /// Show error dialog
            MyPageDialog.showDialog("Error", value.messageData!.content, false);
          }
      }
    });
  }

  getFcmTokenAndCallApi() async{
    // Get Fcm Token from FireBase
    await FirebaseMessageHelper.instance().getFcmToken().then((value) =>
    // Call Api FcmToken After saved access Token and getted Fcm Token
    callApiSendFcmToken());
  }

  // Call Fcm Token Api when Login Success
  callApiSendFcmToken() {
    /// show loading indicator
    EasyLoading.show();
    LoginService.pushFcmToken().then((value) async {
      /// hide loading
      EasyLoading.dismiss();
      switch (value.result) {
        case TaskResult.success:
          print("Push FCM TOKEN Sucess");
          break;
        default:
      }
    });
  }

  setSwitchStatus(bool isOn) {
    isToggled.value = isOn;
    SpUtils.put('isToggled', isOn);
    if (isToggled.value == false) {
      // Remove login info
      saveLogin("", "");
    }
    update();
  }

  //SQL injection check
  // bool validateStructure(String value) {
  //   String pattern =
  //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  //   RegExp regExp = new RegExp(pattern);
  //   return regExp.hasMatch(value);
  // }

  bool validateLogin() {
    if (accountController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    } else
      return true;
  }

  @override
  void onClose() {
    super.onClose();
    accountController.dispose();
    passwordController.dispose();
  }
}
