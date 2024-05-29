import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../model/purchase_list.dart';
import '../../../profile/purchasehistory/purchase_history_page.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';
import '../../../utils/widgets/custom_web_view.dart';
import '../../main/main_controller.dart';
import '../purchase_list_page.dart';

class PurchaseWaitingController extends GetxController {
  RxList<PurchaseList> purchaseList = RxList();
  RxBool isLoading = true.obs;
  RxBool isLoadMore = false.obs;
  int page = 1;

  late WebViewController webViewController;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    getPurchaseList();
    super.onInit();
  }

  void getPurchaseList() async {
    isLoading.value = true;
    isLoadMore.value = false;
    update();
    try {
      final queryParameter = {'page': page, 'limit': 8, 'type': 'waiting'};
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseList, queryParameters: queryParameter);
      purchaseList.value = List<PurchaseList>.from(
          response.data["data"]["data"].map((x) => PurchaseList.fromJson(x)));
      isLoading.value = false;
      isLoadMore.value = true;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      isLoadMore.value = false;
      update();
      log('error purchase list ${e.message}');
    }
  }

  void getMorePurchaseList() async {
    isLoadMore.value = false;
    page++;
    update();
    try {
      final queryParameter = {'page': page, 'limit': 8, 'type': 'waiting'};
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseList, queryParameters: queryParameter);
      purchaseList.addAll(List<PurchaseList>.from(
          response.data["data"]["data"].map((x) => PurchaseList.fromJson(x))));
      isLoadMore.value =
          (purchaseList.length) < response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      isLoadMore.value = false;
      update();
      log('error purchase list ${e.message}');
    }
  }

  void paymentMidtrans(String url) async {
    await initWebView(url);
    Get.to(() => CustomWebView(
          title: 'Payment',
          webViewController: webViewController,
          onWillPop: () async {
            if (await webViewController.canGoBack()) {
              webViewController.goBack();
              return false;
            } else {
              Get.until((route) => Get.currentRoute == '/MainPage');
              Get.find<MainController>().updateIndex(3);
            }
            Get.find<ProfileController>().getTotalPurchaseList();
            return true;
          },
        ));
  }

  Future<void> initWebView(String url) async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://hustle-api.cranium.id/')) {
              Get.until((route) => Get.currentRoute == '/MainPage');
              Get.find<MainController>().updateIndex(3);
              if (request.url.contains('pending')) {
                Get.to(() => const PurchaseListPage());
              } else {
                Get.to(() => const PurchaseHistoryPage());
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }
}
