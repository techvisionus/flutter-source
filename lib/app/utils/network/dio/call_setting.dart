import 'package:dio/dio.dart';
import 'package:flutter_my_page/app/utils/network/task_type.dart';
import 'package:flutter_my_page/app/utils/toast/toast.dart';

import 'callback.dart';
import 'state.dart';

class NetCallSetting {
  final String url; //Request address
  Object? param; //Request parameter
  Map<String, dynamic>? queryParameters; //Request parameter
  NetWorkMethod method = NetWorkMethod.Post; //Request method

  Options? options; //Request configuration
  final CancelToken?
      cancelToken; //The token that can be used to cancel the request. Multiple requests can use the same token. When canceling, all requests for the same token will be cancelled.
  ProgressCallback? onSendProgress; //Used to monitor upload progress
  ProgressCallback? onReceiveProgress; //Used to monitor download progress

  NetWorkCallback? callback; //Request callback

  bool cacheData =
      false; //Whether to cache the data, true, after the cache is turned on, the cache will be used directly within 1 millisecond by default. Use the network before using the cache within 7 days
  NetWorkCacheCallback? cacheCallback; //Get cached callback

  Map<String, dynamic>? extraData;

  //Regarding the use when downloading
  String? _savePath;
  bool _deleteOnError = true;
  String _lengthHeader = Headers.contentLengthHeader;

  String get savePath => _savePath.nullSafe;

  bool get deleteOnError => _deleteOnError;

  String get lengthHeader => _lengthHeader;

  NetCallSetting.get(this.url,
      {Map<String, dynamic>? param,
      NetWorkCallback? callback,
      this.cancelToken,
      Options? options,
      this.cacheData = false,
      this.cacheCallback,
      this.onReceiveProgress,
      this.extraData}) {
    method = NetWorkMethod.Get;
    this.queryParameters = param;
    //Determine whether to include cache configuration
    this.options = _initCallOptions(options);
    if (callback == null) {
      this.callback = DefaultNetWorkCallBack(true);
    } else {
      this.callback = callback;
    }
  }

  NetCallSetting.notGet(this.url, this.method,
      {this.param,
      this.queryParameters,
      this.callback,
      this.cancelToken,
      Options? options,
      this.cacheData = false,
      this.cacheCallback,
      this.onReceiveProgress,
      this.onSendProgress,
      this.extraData}) {
    //Determine whether to include cache configuration
    this.options = _initCallOptions(options);

    if (callback == null) {
      this.callback = DefaultNetWorkCallBack(true);
    } else {
      this.callback = callback;
    }
  }

  NetCallSetting.downLoad(this.url, String savePath,
      {this.param,
      this.queryParameters,
      this.callback,
      this.cancelToken,
      this.options,
      this.onReceiveProgress,
      bool? deleteOnError,
      String? lengthHeader,
      this.extraData}) {
    this._savePath = savePath;
    this._deleteOnError = deleteOnError ?? false;
    this._lengthHeader = lengthHeader.nullSafe;
    if (callback == null) {
      this.callback = DefaultNetWorkCallBack(true);
    } else {
      this.callback = callback;
    }
  }

  Options _initCallOptions(Options? options) {
    Options newOptions;
    if (options == null) {
      newOptions = Options(method: NetWorkMethodUtils.getNetWorkMethod(method));
    } else {
      newOptions = options;
    }
    //todo remove dioHttpCache

    // if (cacheData &&
    //     options.responseType != ResponseType.stream &&
    //     !(options.extra.containsKey(DIO_CACHE_KEY_TRY_CACHE) &&
    //         options.extra[DIO_CACHE_KEY_TRY_CACHE])) {
    //   // The cache configuration is not set --- use the default value
    //   newOptions = buildCacheOptions(Duration(milliseconds: 1),
    //       maxStale: Duration(days: NetWorkCacheSetting.SaveTime),
    //       options: options);
    // }
    if (newOptions.method?.isEmpty ?? true) {
      newOptions.method = NetWorkMethodUtils.getNetWorkMethod(method);
    }
    return newOptions;
  }
}

class DefaultNetWorkCallBack extends NetWorkCallback {
  final bool showToast;

  DefaultNetWorkCallBack(this.showToast);

  @override
  void onNetWorkCallback(TaskResult result, String msg,
      Map<dynamic, dynamic>? response, Map<String, dynamic>? extraData) {
    if (result != TaskResult.success && showToast) {
      try {
        Toast.show(msg);
      } catch (e) {}
    }
  }
}

extension StringExtension on String? {
  String get nullSafe => this ?? "";
}
