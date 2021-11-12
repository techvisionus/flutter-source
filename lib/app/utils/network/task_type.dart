/*
 * @Description: 
 * @Autor: saphir
 * @Date: 2021-04-26 10:21:37
 * @LastEditors: saphir
 * @LastEditTime: 2021-04-29 16:02:25
 */
typedef AsyncParamTask = Future<TaskResult> Function(String param);
typedef AsyncTask = Future<TaskResult> Function();

enum TaskResult {
  /// Error http is not 200
  error,

  /// token failure
  tokenTimeout,

  /// Failed http success return code is not [ApiState.Success]
  fail,

  /// success
  success,

  /// json parsing failed
  parseFail,

  /// Connection timed out
  timeout,
}
