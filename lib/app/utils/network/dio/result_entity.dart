/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-26 10:21:37
 * @LastEditors: saphir
 * @LastEditTime: 2021-04-29 15:59:43
 */

import 'package:flutter_my_page/app/utils/network/dio/state.dart';

import '../task_type.dart';

class ResultEntity<T> {
  TaskResult? result; //Network request result
  Map? responseDataMap; //response data value
  late String resultStatus;
  late MessageEntity? messageData;

  /// The data returned by the data in the response will only have a value when the result is success and it is parsed.
  T? data;
  Map<String, dynamic>?
      extraData; //Additional parameters added to the request interface, do not participate in the request interface

  ResultEntity(this.result, {this.responseDataMap, this.extraData}) {
    this.resultStatus = NetWorkResponse.getResultStatus(responseDataMap);
    this.messageData = NetWorkResponse.getMessageData(responseDataMap);
  }

  bool isSuccess() {
    return (result == TaskResult.success);
  }
}

class MessageEntity<T> {
  Map? responseDataMap; //response data value
  late String code; //The code returned by data in response
  late String content; //msg returned by data in response

  /// The data returned by the data in the response will only have a value when the result is success and it is parsed.
  T? data;
  Map<String, dynamic>?
      extraData; //Additional parameters added to the request interface, do not participate in the request interface

  MessageEntity({this.responseDataMap}) {
    this.code = NetWorkResponse.getCode(responseDataMap);
    this.content = NetWorkResponse.getContent(responseDataMap);
  }
}
