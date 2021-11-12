/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-05-18 09:32:09
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-18 09:33:28
 */
import 'package:get/get.dart';

import '../controllers/transactions_controller.dart';

class TransactionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionsController>(() => TransactionsController());
  }
}
