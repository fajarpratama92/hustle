import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/booking_history_completed.dart'
    as completed;

import '../../../../utils/api/endpoint.dart';
import '../../../../utils/api/rest_api_controller.dart';

class BookingCompletedController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadMore = false.obs;
  RxList<completed.Data> bookingHistory = RxList();

  final RestApiController restApiController = Get.find<RestApiController>();

  int page = 1;

  @override
  void onInit() {
    getBookingHistoryCompleted();
    super.onInit();
  }

  void getBookingHistoryCompleted() async {
    isLoading.value = true;
    isLoadMore.value = false;
    bookingHistory.value = RxList();
    page = 1;
    update();
    try {
      final queryParameter = {'isFuture': 0, 'limit': 8, 'page': page};
      var response = await restApiController.get(
          endpoint: Endpoint.bookingHistoryCompleted,
          queryParameters: queryParameter);
      bookingHistory.value = List<completed.Data>.from(
          response.data["data"]["data"].map((x) => completed.Data.fromJson(x)));
      isLoading.value = false;
      isLoadMore.value =
          (bookingHistory.length) < response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      isLoadMore.value = false;
      update();
      log('error booking history completed ${e.message}');
    }
  }

  void getMoreBookingHistoryCompleted() async {
    isLoadMore.value = true;
    page++;
    update();
    try {
      final queryParameter = {'isFuture': 0, 'limit': 8, 'page': page};
      var response = await restApiController.get(
          endpoint: Endpoint.bookingHistoryCompleted,
          queryParameters: queryParameter);
      bookingHistory.addAll(List<completed.Data>.from(
          response.data["data"]["data"].map((x) => completed.Data.fromJson(x))));
      isLoadMore.value =
          (bookingHistory.length) < response?.data['data']['total'];
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      isLoadMore.value = false;
      update();
      log('error booking history completed ${e.message}');
    }
  }
}
