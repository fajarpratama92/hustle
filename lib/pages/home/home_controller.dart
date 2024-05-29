import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart' hide Banner;
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/active_subscribe.dart';
import 'package:hustle_house_flutter/pages/login/login_page.dart';
import 'package:hustle_house_flutter/utils/api/rest_api_controller.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../model/banner.dart';
import '../../model/booking_history_completed.dart';
import '../../model/class.dart';
import '../../model/user_profile.dart';
import '../../model/voucher.dart';
import '../../profile/profile_controller.dart';
import '../../utils/api/endpoint.dart';
import '../../utils/home_bindings.dart';
import '../../utils/my_pref.dart';
import '../../utils/widgets/custom_dialog.dart';

class HomeController extends GetxController {
  final PageController pageController = PageController();
  late WebViewController webViewController;

  var currentPage = 0.0.obs;
  RxBool isLoadingProfile = false.obs;
  RxBool isLoadingBanner = true.obs;
  RxBool isLoadingClasses = true.obs;
  RxBool isLoadingSubscribe = true.obs;
  RxBool isNewNotification = false.obs;
  Rxn<UserProfile> userProfile = Rxn();
  RxList<ActiveSubscribe> activeSubscribe = RxList();
  RxList<Banner> banners = RxList();
  RxList<SportClass> classes = RxList();
  Rxn<Data> bookingHistoryCompleted = Rxn();
  RxList<Voucher> vouchers = RxList();

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentPage.value = (pageController.page ?? 0.0 + 1.0);
      update();
    });
    getUserProfile();
    getBanner();
    getClasses();
    getActiveSubscribe();
  }

  void getUserProfile() async {
    isLoadingProfile.value = true;
    var myCredit = Get.find<MyPref>().myCredit;
    var accessToken = Get.find<MyPref>().accessToken;
    update();
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.userProfile);
      if (response == null) {
        Get.offAll(() => LoginPage(), binding: HomeBindings());
        accessToken.val = '';
      }
      userProfile.value = UserProfile.fromJson(response.data['data']);
      isLoadingProfile.value = false;
      myCredit.val =
          userProfile.value?.member?.remainingCredit.toString() ?? '0';
      update();
    } on DioException catch (e) {
      isLoadingProfile.value = false;
      update();
      log('error user profile ${e.message}');
    }
  }

  void getBanner() async {
    isLoadingBanner.value = true;
    update();
    try {
      var response = await restApiController.get(endpoint: Endpoint.banner);
      banners.value = List<Banner>.from(
          response.data["data"].map((x) => Banner.fromJson(x)));
      isLoadingBanner.value = false;
      update();
    } on DioException catch (e) {
      isLoadingBanner.value = false;
      update();
      log('error banner ${e.message}');
    }
  }

  void getClasses() async {
    isLoadingClasses.value = true;
    update();
    try {
      final queryParameter = {'homepage': '1', 'category': 'class'};
      var response = await restApiController.get(
          endpoint: Endpoint.sportsClass, queryParameters: queryParameter);
      classes.value = List<SportClass>.from(
          response.data["data"].map((x) => SportClass.fromJson(x)));
      isLoadingClasses.value = false;
      update();
    } on DioException catch (e) {
      isLoadingClasses.value = false;
      update();
      log('error classes ${e.message}');
    }
  }

  void getActiveSubscribe() async {
    isLoadingSubscribe.value = true;
    var isSubscribe = Get.find<MyPref>().isSubscribe;
    update();
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.activeSubscribe);
      activeSubscribe.value = List<ActiveSubscribe>.from(
          response.data["data"].map((x) => ActiveSubscribe.fromJson(x)));
      isLoadingSubscribe.value = false;
      if (activeSubscribe.isNotEmpty) {
        isSubscribe.val = true;
      } else {
        isSubscribe.val = false;
      }
      update();
    } on DioException catch (e) {
      isLoadingSubscribe.value = false;
      update();
      log('error active subscribe ${e.message}');
    }
  }

  void getCompletedBooking(BookingHistoryCompleted? value) {
    bookingHistoryCompleted.value = null;
    for (Data element in value?.data ?? []) {
      if (element.status == 'Attend' && element.isUserComment == false) {
        bookingHistoryCompleted.value = element;
        return;
      } else {
        bookingHistoryCompleted.value = null;
      }
    }
    update();
  }

  String getDateSchedule(String dates) {
    try {
      final date = DateTime.parse(dates);
      final DateFormat formatter = DateFormat.EEEE();
      final DateFormat dateFormat = DateFormat('dd MMMM yyyy');
      final DateFormat hourFormat = DateFormat('HH:mm');
      return '${formatter.format(date)}, ${dateFormat.format(date)} • ${hourFormat.format(date)}';
    } catch (e) {
      log('error format $e');
      return '';
    }
  }

  void reviewClass({String? rate, String? comment}) async {
    Get.dialog(CustomDialog().loading());
    update();
    try {
      final id = bookingHistoryCompleted.value?.id.toString();
      final parameter = {"star_rating": rate, "comments": comment};
      if (double.parse(rate ?? '0.0') <= 0.0) {
        Get.back();
        Get.dialog(CustomDialog().error('Please add rate'));
        return;
      }
      if ((comment?.length ?? 0) > 500) {
        Get.back();
        Get.dialog(CustomDialog().error('Review is too long'));
        return;
      }
      var response = await restApiController.post(
        endpoint: '${Endpoint.reviewClass}/$id',
        data: parameter,
      );
      if (response?.data['status'] == true) {
        Get.dialog(CustomDialog().success('Feedback Sent', () {
          Get.back();
          Get.back();
          Get.back();
          Get.back();
        }));
        Get.find<ProfileController>().getBookingHistoryCompleted();
        update();
      } else {
        Get.back();
        Get.dialog(CustomDialog().error(response?.data['message']));
        update();
      }
      update();
    } on DioException catch (e) {
      update();
      log('error review ${e.message}');
    }
  }

  void getVouchers(List<Voucher> vouchers) {
    this.vouchers.value = RxList();
    Map<String, Voucher> useVoucher = {};
    for (Voucher voucher in vouchers) {
      var key = voucher.rewardVoucher?.code ?? '';
      if (useVoucher.containsKey(key)) {
        useVoucher[key]?.totalVoucher =
            (useVoucher[key]?.totalVoucher ?? 0) + 1;
      } else {
        useVoucher[key] = voucher;
      }
    }
    useVoucher.forEach((key, value) {
      this.vouchers.add(value);
    });
    update();
  }

  void checkNotification() async {
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.notificationCheck);
      isNewNotification.value = response?.data['is_new_notif'];
      update();
    } on DioException catch (e) {
      isLoadingBanner.value = false;
      update();
      log('error notification check ${e.message}');
    }
  }

  void initWebView(String url) {
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
            if (request.url.startsWith('https://hustlehouse.co.id/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) {
    pageController.jumpToPage(index);
  }
}
