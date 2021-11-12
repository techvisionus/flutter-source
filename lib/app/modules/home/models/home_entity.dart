import 'package:flutter_my_page/app/modules/home/models/brokerage_fee.dart';
import 'package:flutter_my_page/app/modules/home/models/notification.dart';
import 'package:flutter_my_page/app/modules/home/models/notifyEntity.dart';
import 'package:flutter_my_page/app/modules/home/models/staff_information.dart';
import 'package:flutter_my_page/app/modules/home/models/transaction_informaion.dart';
import 'package:flutter_my_page/generated/json/base/json_convert_content.dart';
import 'package:get/get.dart';

class HomeEntity with JsonConvert<HomeEntity> {
  Rx<String> loginNumber = "".obs;
  Rx<String> loginName = "".obs;
  NotificationEntity? notificationEntity;
  NotifyEntity? notifyEntity;
  TransactionInfo? transactionInfo;
  BrokerageFee? brokerageFee;
  StaffInfo? staffInfo;

  // HomeEntity([this.notificationEntity]);
  HomeEntity([this.notifyEntity]);
}
