/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-20 09:21:53
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-08 17:35:08
 */
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/features_controller.dart';

class FeaturesPage extends GetView<FeaturesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FeaturesView'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          TextButton(
              onPressed: () {
                controller.startAnimation();
              },
              child: Text("开始动画")),
          SizedBox(
            height: 200,
            child: Container(
              height: controller.animationLogo.value,
              width: controller.animationLogo.value,
              child: FlutterLogo(),
            ),
          ),
          AnimatedBuilder(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User',
              ),
            ),
            animation: controller.animationTextFieldUser,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(controller.animationTextFieldUser.value, 0),
                child: child,
              );
            },
          )
        ],
      )),
    );
  }
}

/// BACKUP HOME
/*
class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr),
        centerTitle: true,
      ),
      body: EasyRefresh(
        controller: controller.refreshController,
        onRefresh: () async {
          controller.page = 1;
          controller.getHomeData();
        },
        onLoad: () async {
          controller.page++;
          controller.getHomeData();
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => GetToast.show("msg"),
                  child: controller.obx(
                    (state) => Text(
                      '''
                      ${state?.account}
                      ${state?.phone}
                      ${state?.username}
                      ${state?.avatar}
                      ''',
                      style: TextStyle(fontSize: 20),
                    ),
                    onError: (error) => EmptyWidget(),
                  ),
                ),
                Text('$environment')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/