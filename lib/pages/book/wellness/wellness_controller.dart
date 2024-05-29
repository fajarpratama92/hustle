import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/widgets/location/location_wellness_controller.dart';

import '../../../model/recovery.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';

class WellnessController extends GetxController {
  RxList<Recovery> wellness = RxList();
  RxBool isLoading = true.obs;
  RxString message = ''.obs;

  late LocationWellnessController locationWellnessController;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    locationWellnessController =
        Get.put(LocationWellnessController(onApplyFilter: () {
      getWellness();
    }));
    getWellness();
    super.onInit();
  }

  void getWellness() async {
    isLoading.value = true;
    message.value = '';
    update();
    try {
      final queryParameter = {
        'location': locationWellnessController.selectedLocation.value
      };
      var response = await restApiController.get(
          endpoint: Endpoint.wellness, queryParameters: queryParameter);
      if (response?.statusCode == 200) {
        wellness.value = List<Recovery>.from(
            response?.data["data"].map((x) => Recovery.fromJson(x)));
      } else {
        message.value = response?.data["message"];
      }

      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error wellness ${e.message}');
    }
  }
}
