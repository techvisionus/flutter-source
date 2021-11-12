/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-05-18 09:32:28
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-18 10:23:39
 */
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_my_page/app/common/helper_function.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/resource/resource_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import 'package:flutter_my_page/app/utils/extensions/extension_dimens.dart';
import 'package:flutter_my_page/app/modules/login/models/login_customcss.dart';
import 'package:flutter_switch/flutter_switch.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF006191),
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              _buildContentlogin(context),
              _buildVersioninfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentlogin(BuildContext context) {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 120.dimension()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Textfield and login button
            Padding(
              padding: EdgeInsets.only(
                  left: 40.0.dimension(), right: 40.0.dimension()),
              child: Column(
                children: [
                  _buildLogo(),
                  SizedBox(height: 25.0),
                  _buildUsername(),
                  SizedBox(height: 25.0),
                  _buildPassword(),
                  SizedBox(height: 30.0),
                  _buildLoginBtn(context),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
            // Divider
            Padding(
              padding: EdgeInsets.only(
                  left: 20.0.dimension(), right: 20.0.dimension()),
              child: Divider(
                thickness: 2,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0.dimension()),
            // Switch button
            _buildSaveinfo(),
            SizedBox(height: 40.0.dimension()),
            _buildUIForgetPass()
          ],
        ),
      ),
    );
  }

  Widget _buildUsername() {
    return Container(
        alignment: Alignment.centerLeft,
        decoration: ASV_BoxStyle1,
        height: 50.0,
        child: TextField(
            controller: controller.accountController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 10.0),
              hintText: 'MEMBER_NUMBER'.tr,
              hintStyle: ASV_HintTextStyle1,
            )));
  }

  Widget _buildPassword() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: ASV_BoxStyle1,
      height: 50.0,
      child: TextField(
        controller: controller.passwordController,
        obscureText: true,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 10.0),
          hintText: 'PASSWORD'.tr,
          hintStyle: ASV_HintTextStyle1,
        ),
      ),
    );
  }

  Widget _buildUIForgetPass() {
    return Padding(
      padding: EdgeInsets.only(left: 40.0.dimension(), right: 40.0.dimension()),
      child: GestureDetector(
        onTap: () {
          HelperFunction.launchURL();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: Dimens.size1, color: ResourceColors.color_F7F7F7),
            borderRadius: BorderRadius.all(Radius.circular(Dimens.size25)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 4.0, 4.0, 4.0),
                    child: SvgPicture.asset(
                      'assets/images/forget_pw_icon.svg',
                      height: Dimens.size25, //Dimens.size15,
                      width: Dimens.size25, //Dimens.size15,
                    ),
                  ),
                  Text("Tìm hiểu thêm về techvisionus",
                      style: new TextStyle(
                        fontSize: DimenFont.sp15,
                        color: ResourceColors.color_FFFFFF,
                        fontFamily: "NotoSansJPMedium",
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 4.0, 8.0, 4.0),
                child: SvgPicture.asset(
                  'assets/images/open_browser_ic.svg',
                  height: Dimens.size18, //Dimens.size15,
                  width: Dimens.size18, //Dimens.size15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(
          onPressed: () async {
            await controller.clickLogin(context);
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFFe1742e))),
          child: Text(
            'LOGIN'.tr,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: DimenFont.sp25,
              fontWeight: FontWeight.w600,
              fontFamily: 'OpenSans',
            ),
          ),
        ));
  }

  Widget _buildLogo() {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/login_logo.svg',
          height: Dimens.size80,
        ),
        Text(
          "TECHVISIONUS",
          style: new TextStyle(
              fontSize: ScreenUtil.getInstance().getSp(28),
              fontFamily: "NotoSansJPBold",
              color: ResourceColors.color_white),
        ),
      ],
    );
  }

  Widget _buildSaveinfo() {
    return Container(
      height: 28.0,
      width: ScreenUtil.getInstance().screenWidth - 180.dimension(),
      child: Center(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('SAVE_LOGIN'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: DimenFont.sp18,
                    fontFamily: 'OpenSans',
                  )),
              Obx(
                () => FlutterSwitch(
                    height: 45.0,
                    width: 45.0,
                    valueFontSize: 25.0,
                    padding: 0,
                    toggleSize: 25.0,
                    borderRadius: 20.0,
                    activeColor: Color(0xFF32d74b),
                    value: controller.isToggled.value,
                    onToggle: (bool value) {
                      controller.setSwitchStatus(value);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVersioninfo() {
    return Container(
      margin: EdgeInsets.only(
          left: 15.0.dimension(),
          bottom: ScreenUtil.getInstance().bottomBarHeight),
      child: Align(
          alignment: Alignment.bottomLeft,
          child: Text('VERSION'.tr,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: DimenFont.sp15,
              ))),
    );
  }
}
