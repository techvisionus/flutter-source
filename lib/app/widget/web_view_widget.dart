import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatelessWidget {
  final String? url;
  final bool? isPdfFile;

  WebViewWidget({required this.url, this.isPdfFile});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(50.0),
      child: dialogContent(context),
    );
  }

  Widget _buildSignupBtn(BuildContext context) {
    return WebView(
      initialUrl: isPdfFile == true ? getLinkForPdfFile(url!) : url!,
      // Enable Javascript on WebView
      javascriptMode: JavascriptMode.disabled,
      userAgent:
          'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36',
    );
  }

  String getLinkForPdfFile(url) {
    String link = url;
    return link;
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
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
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
