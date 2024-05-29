import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/purchaselist/purchase_list_page.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/purchase_history_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../model/order.dart';
import '../../utils/api/endpoint.dart';
import '../../utils/api/rest_api_controller.dart';
import '../../utils/widgets/custom_dialog.dart';
import '../../utils/widgets/custom_web_view.dart';
import '../main/main_controller.dart';

class CheckoutCreditController extends GetxController {
  RxBool isLoading = true.obs;
  RxString discountCode = "Enter discount code".obs;
  Rxn<Order> order = Rxn();
  RxBool isRemoveVoucher = true.obs;
  late WebViewController webViewController;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    getOrderCredit();
    super.onInit();
  }

  void getOrderCredit() async {
    isLoading.value = true;
    discountCode.value = "Enter discount code";
    update();
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.orderCartCredit);
      order.value = Order.fromJson(response.data["data"]);
      if ((order.value?.totalDiscount ?? 0) > 0) {
        await removeVoucher();
        getOrderCredit();
      }
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error cart credit ${e.message}');
    }
  }

  Future<void> discountCredit(String code) async {
    isLoading.value = true;
    discountCode.value = "Enter discount code";
    await removeVoucher();
    update();
    try {
      final orderId = order.value?.id.toString();
      final queryParameter = {"order_id": orderId, "code": code};
      var response = await restApiController.post(
          endpoint: Endpoint.redeemVoucher, queryParameters: queryParameter);
      if (response.data["data"] == null) {
        String? errorMessage = '';
        if (response?.data['errors'].containsKey('Credit')) {
          errorMessage = response?.data['errors']['Credit'].join();
        } else if (response?.data['errors'].containsKey('credit')) {
          errorMessage = response?.data['errors']['credit'].join();
        } else if (response?.data['errors'].containsKey('limit')) {
          errorMessage = response?.data['errors']['limit'].join();
        }
        Get.dialog(CustomDialog().error(errorMessage ?? '', height: 140));
      } else {
        order.value = Order.fromJson(response.data["data"]);
        discountCode.value = code;
      }
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error discount credit ${e.message}');
    }
  }

  Future<void> removeVoucher() async {
    try {
      final orderId = order.value?.id.toString();
      var parameter = {"orderID": orderId};
      await restApiController.post(
          endpoint: Endpoint.removeVoucher, data: parameter);
      update();
    } on DioException catch (e) {
      log('error remove voucher ${e.message}');
    }
  }

  void paymentMidtrans() async {
    Get.dialog(CustomDialog().loading());
    update();
    try {
      final code =
          discountCode.value == 'Enter discount code' ? '' : discountCode.value;
      var parameter = {
        "priceTotal": order.value?.subTotal,
        "credit": order.value?.orderCredit?[0].credit,
        "discountCode": code,
        "discountValue": order.value?.totalDiscount,
        "code": order.value?.code
      };
      var response = await restApiController.post(
          endpoint: Endpoint.midtrans, data: parameter);
      isRemoveVoucher.value = false;
      Get.back();
      if (response?.data['data'].isEmpty) {
        Get.dialog(CustomDialog().success('Purchase Success', () {
          Get.until((route) => Get.currentRoute == '/MainPage');
          Get.find<MainController>().updateIndex(3);
          Get.to(() => const PurchaseHistoryPage());
        }));
        return;
      }
      final url = response?.data['data']['redirect_url'];
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
              return true;
            },
          ));
      update();
    } on DioException catch (e) {
      log('error midtrans ${e.message}');
    }
  }

  Future<void> initWebView(String url) async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
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

              if (request.url == 'https://hustle-api.cranium.id/') {
                Future.delayed(const Duration(seconds: 3), () {
                  Get.find<ProfileController>().getCreditValidHistory();
                  Get.find<ProfileController>().getUserProfile();
                });
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  int getTotal() {
    if ((order.value?.total ?? 0) > 0) {
      return order.value?.total ?? 0;
    }
    return 0;
  }

  @override
  void onClose() {
    if (isRemoveVoucher.isTrue) {
      removeVoucher();
    }
    super.onClose();
  }
}
