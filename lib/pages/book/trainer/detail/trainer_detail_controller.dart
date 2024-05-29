import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/arg_trainer_detail.dart';

import '../../../../model/comment.dart';
import '../../../../model/review.dart';
import '../../../../model/trainer.dart';
import '../../../../profile/bookinghistory/completedclasspage/completedclasscontroller/booking_completed_controller.dart';
import '../../../../profile/profile_controller.dart';
import '../../../../utils/api/endpoint.dart';
import '../../../../utils/api/rest_api_controller.dart';
import '../../../../utils/widgets/custom_dialog.dart';
import '../../../home/home_controller.dart';

class TrainerDetailController extends GetxController {
  RxBool isReadMore = false.obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingReview = true.obs;
  RxBool isCancel = false.obs;
  Rxn<Trainer> trainer = Rxn();
  Rxn<Review> review = Rxn();
  RxList<Comment> comments = RxList();
  RxBool isReturnCredit = false.obs;
  final arguments = Get.arguments;
  int? id = 0;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    id = arguments[ArgTrainerDetail.teacherId];
    getTrainer();
    getReview();
    super.onInit();
  }

  void getTrainer() async {
    isLoading.value = true;
    update();
    try {
      var response =
          await restApiController.get(endpoint: '${Endpoint.teacher}/$id');
      trainer.value = Trainer.fromJson(response.data['data']);
      isLoading.value = false;
      isCancelButton();
      checkStatusCancel();
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error trainer ${e.message}');
    }
  }

  void getReview() async {
    isLoadingReview.value = true;
    update();
    try {
      final teacherId = arguments[ArgTrainerDetail.teacherId];
      final queryParameter = {'teacherID': teacherId, 'page': 1, 'limit': 1};
      var response = await restApiController.get(
          endpoint: Endpoint.reviewTrainer, queryParameters: queryParameter);
      review.value = Review.fromJson(response?.data);
      comments.value = List<Comment>.from(
          response.data["data"]["data"].map((x) => Comment.fromJson(x)));
      isLoadingReview.value = false;
      update();
    } on DioException catch (e) {
      isLoadingReview.value = false;
      update();
      log('error review ${e.message}');
    }
  }

  void reviewTrainer({String? rate, String? comment}) async {
    Get.dialog(CustomDialog().loading());
    update();
    try {
      final id = arguments[ArgTrainerDetail.pathId];
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
        Get.find<BookingCompletedController>().getBookingHistoryCompleted();
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

  void cancelBook() async {
    final id = arguments[ArgTrainerDetail.memberSessionId];
    Get.dialog(CustomDialog().loading());
    update();
    try {
      final parameter = {"memberSessionID": id};
      var response = await restApiController.post(
          endpoint: Endpoint.cancelBook, data: parameter);
      if (response?.data['status'] == true) {
        Get.dialog(CustomDialog().success('Trainer Cancelled', () {
          Get.back();
          Get.back();
          Get.back();
          Get.back();
        }));
        Get.find<HomeController>().getUserProfile();
        Get.find<ProfileController>().getUserProfile();
        Get.find<ProfileController>().getBookingHistoryCancelled();
        Get.find<ProfileController>().getUpcomingClass();
        Get.find<ProfileController>().getAvailableComplimentaryVoucher();
        isCancel.value = false;
        update();
      } else {
        Get.back();
        String? errorMessage = '';
        if (response?.data['errors'].containsKey('code')) {
          errorMessage = response?.data['errors']['code'].join();
        } else if (response?.data['errors'].containsKey('subscribe')) {
          errorMessage = response?.data['errors']['subscribe'].join();
        } else if (response?.data['errors'].containsKey('credit')) {
          errorMessage = response?.data['errors']['credit'].join();
        } else {
          errorMessage = response?.data['message'];
        }
        Get.dialog(CustomDialog().error(errorMessage ?? ''));
        update();
      }
      update();
    } on DioException catch (e) {
      Get.dialog(CustomDialog().error(e.message ?? ''));
      update();
      log('error cancel class ${e.message}');
    }
  }

  void checkStatusCancel() async {
    if (isCancel.isTrue) {
      final id = arguments[ArgTrainerDetail.memberSessionId];
      try {
        final parameter = {"memberSessionID": id};
        var response = await restApiController.get(
            endpoint: Endpoint.checkStatusCancel, queryParameters: parameter);
        isReturnCredit.value = (response?.data['status']
                    .toString()
                    .toLowerCase()
                    .contains('not') ??
                false)
            ? true
            : false;

        update();
      } on DioException catch (e) {
        update();
        log('error status cancel ${e.message}');
      }
    }
  }

  void updateReadMore() {
    isReadMore.value = !isReadMore.value;
    update();
  }

  void isCancelButton() {
    isCancel.value = arguments[ArgTrainerDetail.isCancel] == true ||
        arguments[ArgTrainerDetail.isCancel] != null;
  }

  bool isCancelled() {
    return arguments[ArgTrainerDetail.isCancelled] == true;
  }

  bool isRateClass() {
    bool isFromBookingHistory = Get.previousRoute == '/BookingHistoryPage';
    return isFromBookingHistory &&
        arguments.length > 1 &&
        arguments[ArgTrainerDetail.isUserComment] == false;
  }
}
