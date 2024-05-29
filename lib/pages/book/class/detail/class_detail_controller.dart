import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/class/book_class_controller.dart';
import 'package:hustle_house_flutter/pages/book/class/detail/argument_class_detail.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';
import 'package:hustle_house_flutter/profile/bookinghistory/completedclasspage/completedclasscontroller/booking_completed_controller.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';
import 'package:hustle_house_flutter/utils/widgets/error/error_book.dart';

import '../../../../model/checkout_book.dart';
import '../../../../model/class_detail.dart';
import '../../../../model/comment.dart';
import '../../../../model/review.dart';
import '../../../../utils/api/endpoint.dart';
import '../../../../utils/api/rest_api_controller.dart';
import '../../../../utils/my_pref.dart';
import '../../../../utils/widgets/custom_dialog.dart';
import '../../../bookingclass/class_schedule/class_schedule_controller.dart';
import '../status_book.dart';

class ClassDetailController extends GetxController {
  RxBool isExpandCancellation = false.obs;
  RxBool isExpandPrepare = false.obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingNotify = false.obs;
  RxString codeVoucher = ''.obs;
  Rx<StatusBook> statusBook = StatusBook.notify.obs;
  Rxn<CheckOutBook> checkOutBook = Rxn();
  RxInt id = 0.obs;
  RxInt total = 0.obs;
  var arguments = Get.arguments;
  Rxn<ClassDetail> classDetail = Rxn();
  Rxn<Review> review = Rxn();
  RxList<Comment> comments = RxList();
  RxBool isReturnCredit = false.obs;

  var myCredit = Get.find<MyPref>().myCredit;
  int? memberId;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    statusBook.value = arguments[ArgumentClassDetail.statusBook];
    if (arguments.length > 1) {
      id.value = arguments[ArgumentClassDetail.scheduleId];
      getScheduleDetail();
      getReview();
      sessionSubTotal();
    }
    super.onInit();
  }

  void getScheduleDetail() async {
    isLoading.value = true;
    update();
    try {
      var response = await restApiController.get(
          endpoint: '${Endpoint.scheduleDetail}/$id');
      classDetail.value = ClassDetail.fromJson(response.data['data']);
      isLoading.value = false;
      if (isBooked()) {
        checkStatusCancel();
      }
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error detail class ${e.message}');
    }
  }

  void bookSchedule() async {
    Get.dialog(
      CustomDialog().loading(),
      barrierDismissible: false,
    );
    update();
    try {
      final parameter = {"sessionID": id.toString(), "code": codeVoucher.value};
      var response = await restApiController.post(
          endpoint: Endpoint.scheduleBook, data: parameter);
      if (response?.data['status'] == true) {
        memberId = response?.data['data']['id'];
        Get.back();
        Get.dialog(CustomDialog().success('You\'re All Set!', () {
          Get.back();
          Get.back();
        }));
        updateSchedules();
        updateProfiles();
        statusBook.value = changeStatusBook(statusBook.value);
        checkStatusCancel();
        update();
      } else {
        Get.back();
        errorBook('Booking Failed', response?.data);
        update();
      }
      update();
    } on DioException catch (e) {
      update();
      log('error book class ${e.message}');
    }
  }

  void cancelBook() async {
    final id = memberId ??
        arguments[ArgumentClassDetail.memberSessionId] ??
        classDetail.value?.memberSession?.id.toString() ??
        '';
    Get.dialog(
      CustomDialog().loading(),
      barrierDismissible: false,
    );
    update();
    try {
      final parameter = {"memberSessionID": id};
      var response = await restApiController.post(
          endpoint: Endpoint.cancelBook, data: parameter);
      if (response?.data['status'] == true) {
        Get.back();
        Get.back();
        Get.dialog(CustomDialog().success('Class Cancelled', () {
          Get.back();
        }));
        updateSchedules();
        updateProfiles();
        Get.find<ProfileController>().getBookingHistoryCancelled();
        statusBook.value = changeStatusBook(statusBook.value);
        update();
      } else {
        Get.back();
        errorBook('Cancel Failed', response?.data);
        update();
      }
      update();
    } on DioException catch (e) {
      update();
      log('error cancel class ${e.message}');
    }
  }

  void getReview() async {
    try {
      final sportsClassID = arguments[ArgumentClassDetail.sportsClassId];
      final queryParameter = {
        'sportsClassID': sportsClassID,
        'page': 1,
        'limit': 1
      };
      var response = await restApiController.get(
          endpoint: Endpoint.reviewSportClass, queryParameters: queryParameter);
      review.value = Review.fromJson(response?.data);
      comments.value = List<Comment>.from(
          response.data["data"]["data"].map((x) => Comment.fromJson(x)));
      update();
    } on DioException catch (e) {
      log('error review ${e.message}');
    }
  }

  void reviewClass({String? rate, String? comment}) async {
    Get.dialog(
      CustomDialog().loading(),
      barrierDismissible: false,
    );
    update();
    try {
      final id = arguments[ArgumentClassDetail.bookingHistoryId];
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
          Get.until((route) => Get.currentRoute == '/BookingHistoryPage');
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
      log('error review class ${e.message}');
    }
  }

  Future<void> sessionSubTotal({String? code}) async {
    try {
      final parameter = {"sessionID": id.toString(), "code": code};
      var response = await restApiController.post(
          endpoint: Endpoint.sessionSubTotal, data: parameter);
      total.value = response?.data['data']['total'];
      update();
    } on DioException catch (e) {
      update();
      log('error session sub total ${e.message}');
    }
  }

  void checkStatusCancel() async {
    final id = memberId ??
        arguments[ArgumentClassDetail.memberSessionId] ??
        classDetail.value?.memberSession?.id.toString() ??
        '';
    try {
      final parameter = {"memberSessionID": id};
      var response = await restApiController.get(
          endpoint: Endpoint.checkStatusCancel, queryParameters: parameter);
      isReturnCredit.value =
          (response?.data['status'].toString().toLowerCase().contains('not') ??
                  false)
              ? true
              : false;

      update();
    } on DioException catch (e) {
      update();
      log('error status cancel ${e.message}');
    }
  }

  void notifySchedule() async {
    isLoadingNotify.value = true;
    update();
    try {
      final parameter = {"sessionID": id.toString()};
      var response = await restApiController.post(
          endpoint: Endpoint.notifyMe, data: parameter);
      isLoadingNotify.value = false;
      if (response?.data['status'] == true) {
        memberId = response?.data['data']['id'];
        updateSchedules();
        checkStatusCancel();
        update();
      } else {
        errorBook('Notify Failed', response?.data);
        update();
      }
    } on DioException catch (e) {
      isLoadingNotify.value = false;
      update();
      log('error book class ${e.message}');
    }
  }

  void updateStatusNotify(bool isNotify) {
    notifySchedule();
    if (isNotify) {
      statusBook.value = StatusBook.notified;
    } else {
      statusBook.value = StatusBook.notify;
    }
    update();
  }

  void updateExpandCancellation() {
    isExpandCancellation.value = !isExpandCancellation.value;
    update();
  }

  void updateExpandPrepare() {
    isExpandPrepare.value = !isExpandPrepare.value;
    update();
  }

  void updateCodeVoucher(String value) {
    codeVoucher.value = value;
    initCheckOutBook();
    update();
  }

  void initCheckOutBook() {
    checkOutBook.value = CheckOutBook(
        credit: myCredit.val,
        image: classDetail.value?.sportsClass?.sportsClassAsset?.logoUrl ?? '',
        name: classDetail.value?.sportsClass?.name ?? '',
        hour: classDetail.value?.getHour() ?? '',
        date: classDetail.value?.getDate() ?? '',
        total: total.value.toString(),
        location: classDetail.value?.location?.locationName ?? '',
        trainer:
            '${classDetail.value?.teacher?.firstName} ${classDetail.value?.teacher?.lastName}',
        voucher: codeVoucher.value);
    update();
  }

  bool isShowCredit() {
    bool isFromUpcomingPage = Get.previousRoute == '/UpcomingClassPage';
    bool isFromBookingHistory = Get.previousRoute == '/BookingHistoryPage';
    return statusBook.value == StatusBook.booked && isFromUpcomingPage ||
        statusBook.value == StatusBook.completed && isFromBookingHistory;
  }

  bool isNotCancelled() {
    return statusBook.value != StatusBook.cancelled;
  }

  bool isNotify() {
    return statusBook.value == StatusBook.notify;
  }

  bool isNotifyOrNotified() {
    return statusBook.value == StatusBook.notified ||
        statusBook.value == StatusBook.notify;
  }

  bool isBookOrBooked() {
    return statusBook.value == StatusBook.book ||
        statusBook.value == StatusBook.booked;
  }

  bool isBooked() {
    return statusBook.value == StatusBook.booked;
  }

  bool isBook() {
    return statusBook.value == StatusBook.book;
  }

  void updateSchedules() {
    Get.find<BookClassController>().getSchedules();
    Get.find<ClassScheduleController>().getSchedules();
  }

  void updateProfiles() {
    Get.find<HomeController>().getUserProfile();
    Get.find<ProfileController>().getUserProfile();
    Get.find<ProfileController>().getUpcomingClass();
    Get.find<ProfileController>().getAvailableComplimentaryVoucher();
  }

  bool isDatePassed() {
    DateTime currentDate = DateTime.now();
    final date = DateTime.parse(classDetail.value?.start ?? '');
    if (currentDate.isBefore(date)) {
      return true;
    }
    return false;
  }
}
