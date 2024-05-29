import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/termconditions/model/termcondition.dart';

import '../../utils/api/endpoint.dart';
import '../../utils/api/rest_api_controller.dart';
import 'model/membershipcode.dart';

class MembershipCardController extends GetxController {
  RxList<TermConditionData> termConditionData = RxList();

  //RxList<MembershipCodeData> member = RxList();

  var memberData = MembershipCodeData().obs;

  //RxList<MembershipCodeData> membershipCodeData = RxList();
  var membershipCodeData = ''.obs;
  var isActive = 0.obs;
  var expiredDate = ''.obs;
  RxBool isLoading = true.obs;

  RestApiController restApiController = Get.find<RestApiController>();

  @override
  void onInit() {
    super.onInit();
    fetchMembershipTermServiceFromApi();
    fetchMembershipCodeFromApi();
  }

  void fetchMembershipTermServiceFromApi() async {
    try {
      isLoading.value = true;
      var response = await restApiController.get(
          endpoint: Endpoint.termAndServicesMembership);
      if (response.data['status'] == true) {
        termConditionData.value = List<TermConditionData>.from(
            response.data["data"].map((x) => TermConditionData.fromJson(x)));
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        update();
      }
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error fetch term condition data ${e.message}');
    }
  }

  // void fetchMembershipCodeFromApi() async {
  //   try {
  //     isLoading.value = true;
  //     var response = await restApiController.get(endpoint: Endpoint.memberCode);
  //     if (response.data['status'] == true) {
  //       membershipCodeData.value = response.data['data'];
  //       isLoading.value = false;
  //       update();
  //     } else {
  //       isLoading.value = false;
  //       update();
  //     }
  //   } on DioException catch (e) {
  //     isLoading.value = false;
  //     update();
  //     log('error fetch membershipcode data ${e.message}');
  //   }
  // }

  void fetchMembershipCodeFromApi() async {
    try {
      print('Debug member code 1');
      isLoading.value = true;
      var response = await restApiController.get(endpoint: Endpoint.memberCode);
      if (response.data['status'] == true) {
        membershipCodeData.value = response.data['data']['membershipCode'];
        expiredDate.value = response.data['data']['expired_date'];
        isActive.value = response.data['data']['isActive'];


        //var jsonData = json.decode(response.body);
        //memberData.value = MembershipCodeData.fromJson(jsonData);
        //var jsonResponse = response.body;
        //memberData = json.decode(response.body);
        //membershipCodeData.value = memberData.value.data!.membershipCode ?? '1414';
        //membershipCodeData.value = '34353';
        //print('Debug member code 2');
        // member.value = List<MembershipCodeData>.from(
        //     response.data["data"].map((x) => MembershipCodeData.fromJson(x)));
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        update();
      }
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error fetch membershipcode data ${e.message}');
    }
  }
}
