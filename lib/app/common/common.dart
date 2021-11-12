/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-29 13:54:19
 * @LastEditors: saphir
 * @LastEditTime: 2021-04-29 13:54:20
 */
class Constant {
  /// When the App is running in the Release environment, inProduction is true;
  /// when the App is running in the Debug and Profile environment, inProduction is false

  static bool isDriverTest = false;
  static bool isUnitTest = false;

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';

  static const String keyGuide = 'keyGuide';
  static const String phone = 'phone';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';

  static const String theme = 'AppTheme';
  static const String locale = 'locale';

  static const int NOTIFICATION_TYPE = 0;
  static const int TRANSACTION_INFO_TYPE = 1;
  static const int BROKERAGE_FEE_TYPE = 2;
  static const int STAFF_INFO_TYPE = 3;

  // Config at ASOP
  static const String customschemeASOP = 'asop-ios://';

  // HardCode ip Appstore Google
  static const String idAppStoreASOP = '1559190521';

  static const String idGooglePlayChrome = "com.android.chrome";
}
