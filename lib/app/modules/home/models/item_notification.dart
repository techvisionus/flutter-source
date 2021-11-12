import 'package:flutter_my_page/generated/json/base/json_convert_content.dart';

class ItemNotification with JsonConvert<ItemNotification>{
  bool? isReaded;
  String? content;

  ItemNotification([this.isReaded, this.content]);
}