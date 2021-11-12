import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/modules/home/views/expandableType/notification/notification_main.dart';
import 'package:flutter_my_page/app/modules/home/views/expandableType/web_view_noti_widget.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:flutter_my_page/app/widget/custom_tab_bar/my_page_tab_bar.dart';
import 'package:flutter_my_page/app/widget/custom_tab_bar/my_page_tab_bar_container.dart';
import 'package:flutter_my_page/app/widget/web_view_widget.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            // Create tab header
            _createTab(),
            // Create tab view
            _createTabBarView(context),
          ],
        ),
      ),
    );
  }

  // Create tab view
  Expanded _createTabBarView(_context) {
    return Expanded(
      child: TabBarView(
        controller: controller.tabController,
        children: [
          Stack(
            children: [
              Obx(
                () => Visibility(
                  visible: controller.isShowWebview.isFalse,
                  child: NotificationMain(),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isShowWebview.isTrue,
                  child: WebViewNotiWidget(url: controller.linkWebview),
                ),
              ),
            ],
          ),

          // 2. 落札・入札
          Container(
            child: Center(
              child: Text(
                'DEVELOPING'.tr,
                style: TextStyle(
                  fontSize: DimenFont.sp40,
                  fontFamily: "NotoSansJPBold",
                ),
              ),
            ),
          ),
          // 3. 出品・成約
          Container(
            child: Center(
              child: Text(
                'DEVELOPING'.tr,
                style: TextStyle(
                  fontSize: DimenFont.sp40,
                  fontFamily: "NotoSansJPBold",
                ),
              ),
            ),
          ),

          // 4. その他
          Container(
            child: Center(
              child: Text(
                'DEVELOPING'.tr,
                style: TextStyle(
                  fontSize: DimenFont.sp40,
                  fontFamily: "NotoSansJPBold",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Create tab header
  Widget _createTab() {
    return Obx(
      () => CreateTabBar(
        tabController: controller.tabController,
        isShowTabBar: controller.isShowTabBar,
        tabs: [
          TabContainer(
              tabName: 'IMPORTANT_TAB_TITLE'.tr,
              tabIdx: 0,
              currentTab: controller.currentTabIdx.value),
          TabContainer(
              tabName: 'BID_TAB_TITLE'.tr,
              tabIdx: 1,
              currentTab: controller.currentTabIdx.value),
          TabContainer(
              tabName: 'EXH_SUCCESS_TAB_TITLE'.tr,
              tabIdx: 2,
              currentTab: controller.currentTabIdx.value),
          TabContainer(
              tabName: 'OTHER_TAB_TITLE'.tr,
              tabIdx: 3,
              currentTab: controller.currentTabIdx.value),
        ],
        eventCallBack: () => {
          //   controller.getHomeData()
        },
      ),
    );
  }
}
