/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-29 15:42:27
 * @LastEditors: saphir
 * @LastEditTime: 2021-05-07 09:41:39
 */
import 'package:flutter_my_page/app/modules/home/models/item_notification.dart';
import 'package:flutter_my_page/generated/json/base/json_convert_content.dart';

class NotificationEntity with JsonConvert<NotificationEntity> {
  List<ItemNotification>? listItemNoti;
  NotificationEntity([this.listItemNoti]);
}
