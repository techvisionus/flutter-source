import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_my_page/app/utils/log/log.dart';

import '../async_task.dart';
import '../task_type.dart';

class NetWorkExecutor {
  Future<ResultEntity> request(Dio dio, NetCallSetting callSetting) async {
    try {
      Response response = await dio.request(callSetting.url,
          data: callSetting.param,
          queryParameters: callSetting.queryParameters,
          options: callSetting.options,
          onReceiveProgress: callSetting.onReceiveProgress,
          onSendProgress: callSetting.onSendProgress,
          cancelToken: callSetting.cancelToken);

      if ((callSetting.cacheData) && callSetting.cacheCallback != null) {
        //todo remove dioHttpCache

        callSetting.cacheCallback?.onCacheCallBack(false);
        // //Cache data
        // if (null != response.headers.value(DIO_CACHE_HEADER_KEY_DATA_SOURCE)) {
        //   callSetting.cacheCallback.onCacheCallBack(true);
        // } else {
        //   callSetting.cacheCallback.onCacheCallBack(false);
        // }
      }

      // The return value is abnormal
      if (response == null) {
        // Log.finest(" ----- ResponseError ----- ");
        return handleError(TaskResult.error, response, callSetting);
      }

      // token failure
      if (NetWorkState.isTokenTimeout(response.statusCode ?? 0)) {
        return handleError(TaskResult.tokenTimeout, response, callSetting);
      }

      // Interface call succeeded
      if (NetWorkState.isSuccess(response.statusCode ?? 0)) {
        return handleSuccess(response, callSetting);
      } else {
        // Interface call failed
        return handleError(TaskResult.error, response, callSetting);
      }
    } catch (exception, stack) {
      Log.warning(exception.toString(), exception, stack, false);
      // Log.finest("Exception --- $exception");
      if (exception is DioError && exception.error == TaskResult.tokenTimeout) {
        // token failure
        return handleError(
            TaskResult.tokenTimeout, exception.response, callSetting);
      } else {
        // Abnormal network request
        if (exception is DioError) {
          return handleError(TaskResult.error, exception.response, callSetting);
        } else {
          return handleError(TaskResult.error, null, callSetting);
        }
      }
    }
  }

  Future<ResultEntity> download<T>(Dio dio, NetCallSetting callSetting) async {
    try {
      Response response = await dio.download(
          callSetting.url, callSetting.savePath,
          data: callSetting.param,
          queryParameters: callSetting.queryParameters,
          options: callSetting.options,
          deleteOnError: callSetting.deleteOnError,
          lengthHeader: callSetting.lengthHeader,
          onReceiveProgress: callSetting.onReceiveProgress,
          cancelToken: callSetting.cancelToken);

      if (callSetting.cacheData && callSetting.cacheCallback != null) {
        //todo remove dioHttpCache
        callSetting.cacheCallback?.onCacheCallBack(false);
        // //Cache data
        // if (null != response.headers.value(DIO_CACHE_HEADER_KEY_DATA_SOURCE)) {
        //   callSetting.cacheCallback.onCacheCallBack(true);
        // } else {
        //   callSetting.cacheCallback.onCacheCallBack(false);
        // }
      }

      // The return value is abnormal
      if (response == null) {
        // Log.finest(" ----- ResponseError ----- ");
        return handleError(TaskResult.error, response, callSetting);
      }

      // token failure
      if (NetWorkState.isTokenTimeout(response.statusCode)) {
        return handleError(TaskResult.tokenTimeout, response, callSetting);
      }

      // Interface call succeeded
      if (NetWorkState.isSuccess(response.statusCode)) {
        return handleSuccess(response, callSetting);
      } else {
        // Interface call failed
        return handleError(TaskResult.error, response, callSetting);
      }
    } catch (exception, stack) {
      Log.warning(exception.toString(), exception, stack, false);
      // Log.finest("Exception --- $exception");
      if (exception is DioError && exception.error == TaskResult.tokenTimeout) {
        // token failure
        return handleError(
            TaskResult.tokenTimeout, exception.response, callSetting);
      } else {
        // Abnormal network request
        if (exception is DioError) {
          return handleError(TaskResult.error, exception.response, callSetting);
        } else {
          return handleError(TaskResult.error, null, callSetting);
        }
      }
    }
  }

  // Success callback
  ResultEntity handleSuccess(Response response, NetCallSetting callSetting) {
    Map? responseDataMap = NetWorkResponse.parseResponseData(response);
    // Interface return
    if (ApiState.isSuccess(NetWorkResponse.getResultStatus(responseDataMap))) {
      // Success callback
      callSetting.callback?.onNetWorkCallback(
          TaskResult.success,
          NetWorkResponse.getMsg(responseDataMap),
          responseDataMap,
          callSetting.extraData);
      return ResultEntity(
        TaskResult.success,
        extraData: callSetting.extraData,
        responseDataMap: responseDataMap,
      );
    } else {
      // Failed information processing
      // Log.finest(" ----- ApiFail ----- ");
      return handleError(TaskResult.fail, response, callSetting);
    }
  }

  // Failure callback
  ResultEntity handleError(
      TaskResult result, Response? response, NetCallSetting callSetting) {
    Map? dataMap = NetWorkResponse.parseResponseData(response);

    String msg = NetWorkResponse.getMsg(dataMap);
    if (msg.isEmpty) {
      switch (result) {
        case TaskResult.error:
          msg = "Network Error!";
          break;
        case TaskResult.tokenTimeout:
          msg = "Login invalid!";
          break;
        default:
          msg = "Network Error!";
          break;
      }
    }
    if (callSetting.callback != null) {
      callSetting.callback!
          .onNetWorkCallback(result, msg, dataMap, callSetting.extraData);
    }
    return ResultEntity(
      result,
      extraData: callSetting.extraData,
      responseDataMap: dataMap,
    );
  }
}
