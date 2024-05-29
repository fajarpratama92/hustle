import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/otp/otp_controller.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/colors.dart';

class OtpPage extends StatelessWidget {
  OtpPage(
      {super.key, required this.otpValue, required this.isEmail, this.email});

  final String otpValue;
  final bool isEmail;
  final String? email;

  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left_outlined,
              size: 36,
            ),
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
          )),
      body: GetBuilder<OtpController>(builder: (_) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'OTP Verification',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Enter the OTP sent to ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'D-DIN Exp',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: otpValue,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'D-DIN Exp',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              Container(
                width: 325,
                //margin: const EdgeInsets.symmetric(horizontal: 10),
                child: PinCodeTextField(
                  length: 5,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  enableActiveFill: true,
                  boxShadows: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  pinTheme: PinTheme.defaults(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    selectedColor: Colors.white,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveColor: Colors.white,
                    activeColor: Colors.white,
                  ),
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Oswald',
                    fontWeight: FontWeight.w700,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  onCompleted: (v) async {
                    controller.changeStateButtonDisable(false);
                  },
                  onChanged: (value) {
                    controller.changeStateButtonDisable(true);
                    controller.updateCode(value);
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.labelOtp.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'D-DIN Exp',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Visibility(
                    visible: controller.isTimerStop.isTrue,
                    child: InkWell(
                      onTap: () {
                        if (isEmail) {
                          controller.resendOtpEmail(email: otpValue);
                        } else {
                          controller.resendOtp(email: email ?? '');
                        }
                      },
                      child: Text(
                        'RESEND OTP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: blue,
                          fontSize: 14,
                          fontFamily: 'D-DIN Exp',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.isTimerStop.isFalse,
                    child: Text(
                      '${controller.second.value} Second',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: blue,
                        fontSize: 14,
                        fontFamily: 'D-DIN Exp',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 31,
              ),
              Visibility(
                visible: controller.isLoading.isFalse,
                child: PrimaryButton(
                  text: 'Verify',
                  isDisable: controller.isDisableButton.value,
                  onPressed: () {
                    if (isEmail) {
                      // go to new password
                      controller.verifyOtpEmail(email: otpValue);
                    } else {
                      controller.verifyOtp(email: email ?? '');
                    }
                  },
                ),
              ),
              Visibility(
                visible: controller.isLoading.isTrue,
                child: Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
