import 'dart:io';

import 'package:flutter_my_page/app/common/common.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';

class HelperFunction {
  static launchURL() async {
    const url = 'https://techvisionus.com/';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static void launcASOPApp() async {
    print("try to open installed app");
    await canLaunch(Constant.customschemeASOP)
        ? await launch(Constant.customschemeASOP)
        : launchAppStoreOrGooglePlay();
  }

  static void launchAppStoreOrGooglePlay() {
    print("try to open app store");
    if (Platform.isIOS) {
      LaunchReview.launch(
          writeReview: false, iOSAppId: Constant.idAppStoreASOP);
    } else {
      LaunchReview.launch(
          androidAppId: Constant.idGooglePlayChrome,
          iOSAppId: Constant.idAppStoreASOP);
    }
  }
}
