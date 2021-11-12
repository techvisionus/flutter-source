import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_my_page/app/utils/log/log.dart';
import 'package:flutter_my_page/app/utils/network/async_task.dart';

enum NetWorkMethod { Get, Post, Delete, Put, Head, Patch }

class NetWorkMethodUtils {
  static String getNetWorkMethod(NetWorkMethod method) {
    switch (method) {
      case NetWorkMethod.Get:
        return "GET";
      case NetWorkMethod.Post:
        return "POST";
      case NetWorkMethod.Delete:
        return "DELETE";
      case NetWorkMethod.Put:
        return "PUT";
      case NetWorkMethod.Head:
        return "HEAD";
      case NetWorkMethod.Patch:
        return "PATCH";
      default:
        return 'GET';
    }
  }
}

class NetWorkCacheSetting {
  static const int CacheTime =
      1; // Time to get cached Info directly (milliseconds) ----- Skip network request
  static const int SaveTime = 7; // Database storage time (days)
}

// Interface return information
class NetWorkResponse {
  static const String _Code = "code";
  static const String _Content = "content";
  static const String _Msg = "msg";
  static const String _Data = "data";
  static const String _ResultStatus = "resultStatus";
  static const String _AccessToken = "accessToken";
  static const String _Message = "message";

  static String getResultStatus(Map? map) {
    if (map == null || !map.containsKey(_ResultStatus)) return "";
    return map[_ResultStatus].toString();
  }

  static String getCode(Map? map) {
    if (map == null || !map.containsKey(_Code)) return "";
    return map[_Code].toString();
  }

  static String getContent(Map? map) {
    if (map == null || !map.containsKey(_Content)) return "";
    return map[_Content].toString();
  }

  static String getMsg(Map? map) {
    if (map == null || !map.containsKey(_Msg)) return "";
    return map[_Msg].toString();
  }

  static String getAccessToken(Map? map) {
    if (map == null || !map.containsKey(_AccessToken)) return "";
    return map[_AccessToken];
  }

  static getData(Map? map) {
    if (map == null || !map.containsKey(_Data)) return null;
    return map[_Data];
  }

  static MessageEntity? getMessageData(Map? map) {
    if (map == null || !map.containsKey(_Message)) return null;
    MessageEntity msgEntity = MessageEntity(responseDataMap: map[_Message]);
    return msgEntity;
  }

  static Map? parseResponseData(Response? response) {
    if (response != null && response.data != null) {
      try {
        String jsonString = json.encode(response.data);
        Map resultMap = jsonDecode(jsonString);
        return resultMap;
      } catch (exception, stack) {
        Log.warning(exception.toString(), exception, stack, false);
        return null;
      }
    }
    return null;
  }
}

// Link status
class NetWorkState {
  static const int Success = 200;
  static const int TokenTimeout =
      401; // Token expires --- time / server restart. . .

  static bool isSuccess(int? code) {
    return (Success == code);
  }

  static bool isTokenTimeout(int? code) {
    return (TokenTimeout == code);
  }
}

// Interface status
class ApiState {
  static const String Success = "0";

  static bool isSuccess(String code) {
    return (Success == code);
  }
}

/// The token may always be in the expired (401) state when the server restarts --- avoid loop refresh and lockup
class TokenCounter {
  static int _maxTime = 2; // token refreshes at most
  static int _tokenRefreshCounter = 0; // token refresh count,

  static void refreshCounter() {
    _tokenRefreshCounter = 0;
  }

  static void addCounter() {
    _tokenRefreshCounter++;
  }

  static bool counterIsMax() {
    if (_tokenRefreshCounter < _maxTime) {
      return false;
    }
    // refreshCounter();
    return true;
  }
}
