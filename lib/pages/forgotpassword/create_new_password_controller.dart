import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/otp/otp_success_page.dart';

import '../../utils/api/endpoint.dart';
import '../../utils/api/rest_api_controller.dart';
import '../../utils/widgets/custom_dialog.dart';

class NewPasswordController extends GetxController {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPasswordConfirmController =
      TextEditingController();

  RxBool passwordsMatch = false.obs;
  RxBool isLoading = false.obs;

  RestApiController restApiController = Get.find<RestApiController>();

  void checkPasswords() {
    final newPass = newPasswordController.text;
    final newPassConfirm = newPasswordConfirmController.text;
    if (newPass == newPassConfirm && newPass.length > 7) {
      passwordsMatch.value = true;
    } else {
      passwordsMatch.value = false;
    }
    // passwordsMatch.value = newPass == newPassConfirm;
    update();
  }

  void createNewPassword(
      String email,
      TextEditingController newPasswordController,
      TextEditingController newPasswordConfirmController,
      String code) async {
    //Get.dialog(CustomDialog().error(email));
    //send to server
    try {
      isLoading.value = true;
      var parameter = {
        "email": email,
        "password": newPasswordController.text,
        "password_confirmation": newPasswordConfirmController.text,
        "code": code
      };
      var response = await restApiController.post(
          endpoint: Endpoint.forgotPasswordMobile, data: parameter);
      isLoading.value = false;
      if (response.data['status'] == false) {
        //Get.to(() => RegisterStep2Page());
        Get.dialog(CustomDialog().error('Fail to Change Password'));
        //isHasEmail.value = false;
        update();
      } else {
        //goto ganti pass
        Get.to(() => OtpSuccessPage(
            // title: 'Password Changed',
            // subtitle: 'Your password has been changed successfully.',
            isNewPassword: true));
        //Get.dialog(CustomDialog().error('Succsess'));
        update();
      }
    } on DioException catch (e) {
      isLoading.value = false;
      update();
      log('error create new password ${e.message}');
    }
  }
}
