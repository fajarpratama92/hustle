import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/otp/otp_page.dart';

import '../../utils/api/endpoint.dart';
import '../../utils/widgets/custom_dialog.dart';
import 'package:hustle_house_flutter/utils/api/rest_api_controller.dart';

class ForgotPasswordController extends GetxController {
  RxBool isValidEmail = false
      .obs; // isValidEmail adalah variabel yang akan dipantau (observable) oleh GetX
  RxBool isLoading = false.obs;
  RxBool isHasEmail = true.obs;

  RestApiController restApiController = Get.find<RestApiController>();

  void validateEmail(String email) {
    // fungsi validasi email
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    isValidEmail.value = emailRegExp.hasMatch(email);
    update();
  }

  // void isOn(){
  //   isLoading.value = true;
  //   isValidEmail.value = false;
  //   update();
  // }

  //cek email apakah terdaftar di server
  void checkEmail(String email) async {
    isLoading.value = true;
    try {
      var parameter = {"email": email};
      var response = await restApiController.post(
          endpoint: Endpoint.checkEmail, data: parameter);
      isLoading.value = false;
      if (response.data['status'] == false) {
        //Get.to(() => RegisterStep2Page());
        //Get.dialog(CustomDialog().error('Email Not Found'));
        isHasEmail.value = false;
        update();
      } else {
        isHasEmail.value = true;
        sendOtpToEmail(email);
        //Get.to(() => OtpPage(otpValue: email, isEmail: true));
        //tampilkan ke textview
        //Get.dialog(CustomDialog().error(response.data['message']));
        update();
      }
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error check email ${e.message}');
    }
  }

  void sendOtpToEmail(String email) async {
    isLoading.value = true;
    try {
      var parameter = {"email": email};
      var response = await restApiController.post(
          endpoint: Endpoint.forgotPasswordMobile, data: parameter);
      isLoading.value = false;
      if (response.data['status'] == false) {
        //Get.to(() => RegisterStep2Page());
        Get.dialog(CustomDialog().error('Fail to Send Email OTP'));
        //isHasEmail.value = false;
        update();
      } else {
        //goto ganti pass
        Get.to(() => OtpPage(otpValue: email, isEmail: true));
        update();
      }
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error send otp to email ${e.message}');
    }

    //Get.to(() => OtpPage(otpValue: email, isEmail: true));
  }
}
