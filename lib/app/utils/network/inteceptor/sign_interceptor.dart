import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';

class SignInterceptor extends Interceptor {
  static String APPID = "app-mobile";
  static String AppSecret = "afea16bd1f";

  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
    final Uri uri = options.uri;
    var json = '';
    var map = new HashMap.from(uri.queryParameters);
    if (options.queryParameters != null) {
      map.addAll(options.queryParameters);
    }
    if (options.data != null) {
      var contentType = ContentType.parse(options.contentType ?? 'json');
      // application/x-www-form-urlencoded Data in form
      if (options.data is String) {
        var data = options.data as String;
        if (data.contains("=")) {
          data.split("&").forEach((entry) {
            var a = entry.split("=");
            map[a[0]] = a[1].toString();
          });
        }
      }
      // multipart/form-data Formatted data
      else if (options.data is FormData) {
        var data = options.data as FormData;
        map.addEntries(data.fields);
        data.files.forEach((value) {
          map[value.key] = value.value;
        });
      }
      // application/x-www-form-urlencoded Data in form
      else if (options.data is Map &&
          contentType.subType == 'x-www-form-urlencoded') {
        map.addAll(options.data);
      }
      // application/json; charset=utf-8 Data in Json format
      else if (options.data is Map && contentType.subType == 'json') {
        var treeMap = SplayTreeMap.of(options.data);
        sortMapData(treeMap);
        json = jsonEncode(treeMap);
      } else {
        json = jsonEncode(options.data);
      }
    }

    // Argument ordering
    List<String> list = List.from(map.keys);
    list.sort((a, b) {
      return a.compareTo(b);
    });

    StringBuffer buffer = new StringBuffer();
    var timestamp = DateTime.now().millisecondsSinceEpoch; // Timestamp

    list.forEach((key) {
      if (buffer.length > 0) {
        buffer.write('&');
      }
      // Request string
      buffer.write(key);
      buffer.write('=');
      buffer.write(Uri.encodeQueryComponent('${map[key]}'));
    });

    // json format needs to be added separately
    buffer.write(json);
    // Timestamp
    buffer.write(timestamp);

    var signature = getHMacMd5Str(AppSecret, buffer.toString());

    // Signature related request header
    options.headers["appId"] = APPID;
    options.headers["timestamp"] = timestamp;
    options.headers["signature"] = signature;
    // options.headers["forcecheck"] = "1";
    return options;
  }

  void sortMapData(SplayTreeMap treeMap) {
    treeMap.forEach((key, value) {
      // map
      if (value is Map) {
        treeMap[key] = SplayTreeMap.of(value);
        // Recursive sort
        sortMapData(treeMap[key]);
      }
      // list
      else if (value is List) {
        var list = sortList(value);
        treeMap[key] = list;
      } else {
        // Other types
      }
    });
  }

  List sortList(List list) {
    var temp = List.of({});
    list.sort((o1, o2) {
      if (o1 is String && o2 is String) {
        return o1.compareTo(o2);
      } else if (o1 is num && o2 is num) {
        return o1.compareTo(o2);
      }
      return 0;
    });
    list.forEach((item) {
      if (item is Map) {
        var m = SplayTreeMap.of(item);
        sortMapData(m);
        temp.add(m);
      } else if (item is List) {
        sortList(item);
      } else {
        temp.add(item);
      }
    });
    return temp;
  }

  /// hmac_md5
  /// Returns a hexadecimal string 16
  static String getHMacMd5Str(String secret, String message) {
    List<int> secretBytes = utf8.encode(secret);
    List<int> messageBytes = utf8.encode(message);

    //  var hmac = new Hmac(sha256.newInstance(), secretBytes); // sha256
    //  var hmac = new Hmac(sha1, secretBytes); // sha1
    var hmac = new Hmac(md5, secretBytes); // md5
    var bytes = hmac.convert(messageBytes).toString();
    return bytes;
  }

  // Future onResponse(Response response) async {
  //   return response; // continue
  // }

  // Future onError(DioError e) async {
  //   return e; //continue
  // }

  static void callback(bool isSuccess, String msg) {}
}
