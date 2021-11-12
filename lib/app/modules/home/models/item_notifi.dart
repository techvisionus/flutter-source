import 'package:json_annotation/json_annotation.dart';


part 'item_notifi.g.dart';


@JsonSerializable()
class ItemNotifi {
  String? id;
  String? noticeKbn;
  String? title;
  String? message;
  String? link;
  String? fromDate;

  ItemNotifi(
      {this.id,
      this.noticeKbn,
      this.title,
      this.message,
      this.link,
      this.fromDate});

  factory ItemNotifi.fromJson(Map<String, dynamic> json) =>
      _$ItemNotifiFromJson(json);

  Map<String, dynamic> toJson() => _$ItemNotifiToJson(this);
}
