/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-27 15:55:46
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-08 17:52:10
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChargeDetailController extends GetxController
    with SingleGetTickerProviderMixin, StateMixin {
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
