// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_notifi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemNotifi _$ItemNotifiFromJson(Map<String, dynamic> json) {
  return ItemNotifi(
    id: json['id'] as String?,
    noticeKbn: json['noticeKbn'] as String?,
    title: json['title'] as String?,
    message: json['message'] as String?,
    link: json['link'] as String?,
    fromDate: json['fromDate'] as String?,
  );
}

Map<String, dynamic> _$ItemNotifiToJson(ItemNotifi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'noticeKbn': instance.noticeKbn,
      'title': instance.title,
      'message': instance.message,
      'link': instance.link,
      'fromDate': instance.fromDate,
    };
