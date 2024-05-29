
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';
import 'package:hustle_house_flutter/pages/forgotpassword/create_new_password_controller.dart';

import '../../utils/widgets/custom_text_form_field.dart';
import '../../utils/colors.dart';

class CreateNewPasswordPage extends StatelessWidget {
  CreateNewPasswordPage({super.key, required this.code, required this.email});

  final String code;
  final String email;

  final NewPasswordController newpasscontroller =
      Get.put(NewPasswordController());

  // final TextEditingController _newpassController = TextEditingController();
  // final TextEditingController _newpassConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<NewPasswordController>(builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 13, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: SvgPicture.asset(
                                'assets/images/chevron-left-outline.svg'))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Create New Password',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 14, right: 15),
                    child: Column(children: [
                      Text(
                        'Your new password must be different from your previous password.',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'D-DIN Exp',
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      CustomTextFormField(
                        labelText: 'New Password',
                        isObscure: true,
                        isPassword: true,
                        hintText: 'Enter your new password',
                        controller: newpasscontroller.newPasswordController,
                        onChanged: (value) {
                          newpasscontroller.checkPasswords();
                        },
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            newpasscontroller
                                        .newPasswordController.text.length <
                                    8
                                ? Text(
                                    'Must be at least 8 characters',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: newpasscontroller
                                              .newPasswordController
                                              .text
                                              .isNotEmpty
                                          ? Colors.grey
                                          : Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'D-DIN Exp',
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      CustomTextFormField(
                        labelText: 'Confirm New Password',
                        hintText: 'Enter your new password',
                        isObscure: true,
                        isPassword: true,
                        controller:
                            newpasscontroller.newPasswordConfirmController,
                        onChanged: (value) {
                          newpasscontroller.checkPasswords();
                        },
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            newpasscontroller.newPasswordController.text.isEmpty
                                ? Text(
                                    'Both passwords must match',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'D-DIN Exp',
                                    ),
                                  )
                                : !newpasscontroller.passwordsMatch.value
                                    ? Text(
                                        'Password do not match',
                                        style: TextStyle(
                                          color: fireOrange,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'D-DIN Exp',
                                        ),
                                      )
                                    : Container()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 31,
                      ),
                      PrimaryButton(
                        text: 'Reset Password',
                        isDisable: !newpasscontroller.passwordsMatch.value,
                        onPressed: () {
                          newpasscontroller.createNewPassword(
                              email,
                              newpasscontroller.newPasswordController,
                              newpasscontroller.newPasswordConfirmController,
                              code);
                        },
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
