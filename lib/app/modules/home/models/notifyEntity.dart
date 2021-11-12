import 'package:flutter_my_page/app/modules/home/models/item_notifi.dart';
import 'package:flutter_my_page/generated/json/base/json_convert_content.dart';
import 'package:json_annotation/json_annotation.dart';


class NotifyEntity with JsonConvert<NotifyEntity>{
  List<ItemNotifi>? data;
  NotifyEntity([this.data]);

}