import 'dart:convert';
import 'package:flutter_my_page/app/modules/home/models/item_notifi.dart';
import 'package:flutter_my_page/app/modules/home/models/notifyEntity.dart';
import 'package:flutter_my_page/app/modules/login/models/user_info_entity.dart';
import 'package:flutter_my_page/app/utils/log/log.dart';
import 'package:flutter_my_page/app/utils/network/async_task.dart';
import 'package:flutter_my_page/app/utils/network/dio/callback.dart';
import 'package:flutter_my_page/app/utils/network/dio/result_entity.dart';

bool isType<T1, T2>() => T1 == T2;

///Need to remove private add when using, call [NetWork.init] (NetWork().init) method
///When using, you can add the analysis of responseDataMap in [ResultEntity]
abstract class NetWorkHttpUtils {
  Future<ResultEntity<T>> get<T>(String url,
      {Map<String, dynamic>? param,
      NetWorkCallback? callback,
      Options? options,
      cancelToken,
      Map<String, dynamic>? extraData}) async {
    return request<T>(NetCallSetting.get(url,
        param: param,
        callback: callback,
        options: options,
        cancelToken: cancelToken,
        extraData: extraData));
  }

  Future<ResultEntity<T>> post<T>(String url,
      {param,
      Map<String, dynamic>? queryParameters,
      NetWorkCallback? callback,
      Options? options,
      CancelToken? cancelToken,
      Map<String, dynamic>? extraData}) async {
    return request<T>(NetCallSetting.notGet(url, NetWorkMethod.Post,
        param: param,
        queryParameters: queryParameters,
        callback: callback,
        options: options,
        cancelToken: cancelToken,
        extraData: extraData));
  }

  Future<ResultEntity<T>> put<T>(String url,
      {param,
      Map<String, dynamic>? queryParameters,
      NetWorkCallback? callback,
      Options? options,
      CancelToken? cancelToken,
      Map<String, dynamic>? extraData}) async {
    return request<T>(NetCallSetting.notGet(url, NetWorkMethod.Put,
        param: param,
        queryParameters: queryParameters,
        callback: callback,
        options: options,
        cancelToken: cancelToken,
        extraData: extraData));
  }

  Future<ResultEntity<T>> delete<T>(String url,
      {param,
      Map<String, dynamic>? queryParameters,
      NetWorkCallback? callback,
      Options? options,
      CancelToken? cancelToken,
      Map<String, dynamic>? extraData}) async {
    return request<T>(NetCallSetting.notGet(url, NetWorkMethod.Delete,
        param: param,
        queryParameters: queryParameters,
        callback: callback,
        options: options,
        cancelToken: cancelToken,
        extraData: extraData));
  }

  Future<ResultEntity<T>> head<T>(String url,
      {param,
      Map<String, dynamic>? queryParameters,
      NetWorkCallback? callback,
      Options? options,
      CancelToken? cancelToken,
      Map<String, dynamic>? extraData}) async {
    return request<T>(NetCallSetting.notGet(url, NetWorkMethod.Head,
        param: param,
        queryParameters: queryParameters,
        callback: callback,
        options: options,
        cancelToken: cancelToken,
        extraData: extraData));
  }

  Future<ResultEntity<T>> patch<T>(String url,
      {param,
      Map<String, dynamic>? queryParameters,
      NetWorkCallback? callback,
      Options? options,
      CancelToken? cancelToken,
      Map<String, dynamic>? extraData}) async {
    return request<T>(NetCallSetting.notGet(url, NetWorkMethod.Patch,
        param: param,
        queryParameters: queryParameters,
        callback: callback,
        options: options,
        cancelToken: cancelToken,
        extraData: extraData));
  }

  T parserData<T>(Map? responseDataMap, {int? type = 0}) {
    late T data;
    if (responseDataMap != null) {
      Map? responseData;
      List<dynamic>? responseDataList;

      switch (type) {
        case 0:
          responseData = NetWorkResponse.getData(responseDataMap);
          break;
        case 1:
          // Login response
          responseData = responseDataMap;
          break;
        case 2:
          responseDataList = NetWorkResponse.getData(responseDataMap);
          break;
        default:
          responseData = NetWorkResponse.getData(responseDataMap);
          break;
      }

      try {
        if (responseData != null) {
          data = getResponseData(responseData);
        } else if (responseDataList != null) {
          data = getResponseDataList(responseDataList);
        }
      } catch (e, s) {
        Log.warning(e.toString(), e, s, false);
      }
    }
    return data;
  }

  T getResponseDataList<T>(List<dynamic>? responseDataList) {
    late T data;
    data = jsonParseData(responseDataList);
    return data;
  }

  T getResponseData<T>(Map? responseData){
    late T data;
      switch (T.toString()) {
        case "dynamic":
          data = responseData as T;
          print(data);
          break;
        case "String":
          if (responseData is List) {
            data = jsonEncode(responseData) as T;
          }
          data = responseData.toString() as T;

          break;
        default:
          if (T.toString().startsWith("Map") ||
              T.toString().startsWith("List<Map")) {
            data = responseData as T;
          } else {
            data = jsonParseData(responseData);
          }
          break;
      }
    return data;
  }

  T jsonParseData<T>(dynamic responseData);

  Future<ResultEntity<T>> request<T>(NetCallSetting callSetting) async {
    ResultEntity entity = (await NetWork().request(callSetting: callSetting))!;
    int type = 0;
    if (isType<T, UserInfoEntity>()) {
      // call login api
      type = 1;
    }

    if (isType<T, NotifyEntity>()) {
      // call API get Notification
      type = 2;
    }
    // If response is null
    if (entity.responseDataMap == null) {
      ResultEntity<T> result =
          ResultEntity(entity.result, extraData: entity.extraData);
      return result;
    }

    // If response has "data"
    T data = parserData(entity.responseDataMap, type: type);
    ResultEntity<T> resultEntity =
        ResultEntity(entity.result, extraData: entity.extraData)
          ..resultStatus = entity.resultStatus
          ..messageData = entity.messageData
          ..data = data
          ..responseDataMap = entity.responseDataMap;
    return resultEntity;
  }

  Future<ResultEntity> download(String url, String savePath,
      {bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      param,
      Map<String, dynamic>? queryParameters,
      NetWorkCallback? callback,
      Options? options,
      ProgressCallback? onReceiveProgress,
      CancelToken? cancelToken,
      Map<String, dynamic>? extraData}) async {
    ResultEntity entity = await NetWork().download(
        callSetting: NetCallSetting.downLoad(url, savePath,
            deleteOnError: deleteOnError,
            lengthHeader: lengthHeader,
            param: param,
            queryParameters: queryParameters,
            callback: callback,
            cancelToken: cancelToken,
            options: options,
            onReceiveProgress: onReceiveProgress,
            extraData: extraData));
    return entity;
  }
}
