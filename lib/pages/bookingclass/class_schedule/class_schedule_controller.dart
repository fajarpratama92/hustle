import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/class.dart';
import 'package:hustle_house_flutter/utils/widgets/location/location_controller.dart';
import 'package:intl/intl.dart';

import '../../../model/schedule.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';
import '../../../utils/my_pref.dart';

class ClassScheduleController extends GetxController {
  var arguments = Get.arguments;
  final dates = List<DateTime>.generate(
      30,
      (i) => DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).add(Duration(days: i)));

  Rxn<SportClass> sportClass = Rxn();
  RxString month = DateFormat('MMMM yyyy').format(DateTime.now()).obs;
  RxInt currentIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingCredit = false.obs;
  RxList<Schedule> schedules = RxList();

  final RestApiController restApiController = Get.find<RestApiController>();
  late LocationController locationController;

  @override
  void onInit() {
    if (arguments is SportClass) {
      sportClass.value = arguments;
    }
    locationController = Get.put(LocationController(onApplyFilter: () {
      getSchedules();
    }));
    locationController.resetFilter();
    getSchedules();
    super.onInit();
  }

  void getSchedules() async {
    var selectedDate =
        DateFormat('yyyy-MM-dd').format(dates[currentIndex.value]);
    isLoading.value = true;
    update();
    try {
      final queryParameter = {
        'date': selectedDate,
        'class_id': sportClass.value?.id,
        'location_id': locationController.locationSelected.join(','),
      };
      var response = await restApiController.get(
          endpoint: Endpoint.schedule, queryParameters: queryParameter);
      schedules.value = List<Schedule>.from(
          response.data["data"].map((x) => Schedule.fromJson(x)));
      getPriceActiveSubscribe();
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error schedules ${e.message}');
    }
  }

  Future<int> sessionSubTotal(String id) async {
    try {
      final parameter = {"sessionID": id.toString()};
      var response = await restApiController.post(
          endpoint: Endpoint.sessionSubTotal, data: parameter);
      update();
      if (response?.statusCode == 200) {
        return response?.data['data']['total'];
      }
    } on DioException catch (e) {
      update();
      log('error session sub total ${e.message}');
    }
    return 0;
  }


  void getPriceActiveSubscribe() async {
    var isSubscribe = Get.find<MyPref>().isSubscribe;
    if (isSubscribe.val) {
      isLoadingCredit.value = true;
      for (int i = 0; i < schedules.length; i++) {
        var schedule = schedules[i];
        schedules[i].price = await sessionSubTotal(schedule.id.toString());
      }
      isLoadingCredit.value = false;
      update();
    }
  }

  void updateMonth(String value) {
    month.value = value;
    update();
  }

  void updateIndex(int index) {
    currentIndex.value = index;
    update();
  }
}
