import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_my_page/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class WebViewNotiWidget extends GetView<HomeController> {
  final String? url;

  WebViewNotiWidget({this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(50.0),
      child: dialogContent(context),
    );
  }

  Widget _buildSignupBtn(BuildContext context) {
    return WebView(
      initialUrl: url!,
      // Enable Javascript on WebView
      javascriptMode: JavascriptMode.disabled,
      userAgent:
          'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36',
    );
  }

  Widget dialogContent(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            // height: 600,
            // the most important part of this example
            child: _buildSignupBtn(context)),
        Positioned(
          right: 0.0,
          top: 2.0,
          child: GestureDetector(
            onTap: () {
              controller.isShowWebview.value = false;
            },
            child: Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 14.0,
                backgroundColor: Colors.white,
                child: Icon(Icons.close, color: Colors.red),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
