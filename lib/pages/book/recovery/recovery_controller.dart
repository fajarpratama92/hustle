import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/widgets/location/location_recovery_controller.dart';

import '../../../model/recovery.dart';
import '../../../utils/api/endpoint.dart';
import '../../../utils/api/rest_api_controller.dart';

class RecoveryController extends GetxController {
  RxList<Recovery> recoveries = RxList();
  RxBool isLoading = true.obs;
  RxString message = ''.obs;

  late LocationRecoveryController locationRecoveryController;

  final RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    locationRecoveryController = Get.put(LocationRecoveryController(onApplyFilter: () {
      getRecovery();
    }));
    locationRecoveryController.resetFilter();
    getRecovery();
    super.onInit();
  }

  void getRecovery() async {
    isLoading.value = true;
    message.value = '';
    update();
    try {
      final queryParameter = {
        'location': locationRecoveryController.selectedLocation.value
      };
      var response = await restApiController.get(
          endpoint: Endpoint.recovery, queryParameters: queryParameter);
      if (response?.statusCode == 200) {
        recoveries.value = List<Recovery>.from(
            response?.data["data"].map((x) => Recovery.fromJson(x)));
      } else {
        message.value = response?.data["message"];
      }

      isLoading.value = false;
      update();
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error recovery ${e.message}');
    }
  }
}
