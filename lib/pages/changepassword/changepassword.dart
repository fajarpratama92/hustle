import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/bookingclass/widget/appbar.dart';
import 'package:hustle_house_flutter/pages/changepassword/change_password_controller.dart';
import 'package:hustle_house_flutter/pages/forgotpassword/forgot_password.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/custom_text_form_field.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final changepasswordcontroller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarBookingClass(
        title: 'Change Password',
        onBackTap: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<ChangePasswordController>(builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  height: 10,
                  indent: 0,
                  color: gray1, // Warna abu-abu
                  thickness: 10, // Ketebalan pemisah (1 piksel)
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        labelText: 'Current Password',
                        hintText: 'Enter password',
                        controller:
                            changepasswordcontroller.oldPasswordController,
                        isObscure: true,
                        isPassword: true,
                        onChanged: (value) {
                          changepasswordcontroller.checkPasswordsValid();
                        },
                      ),
                      const SizedBox(height: 8),
                      Visibility(
                        visible: changepasswordcontroller.isPasswordTrue.value,
                        //visible: false,
                        child: Text(
                          'Wrong password',
                          style: TextStyle(
                            color: red,
                            fontSize: 14,
                            fontFamily: 'D-DIN Exp',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        labelText: 'New Password',
                        hintText: 'Enter password',
                        controller:
                            changepasswordcontroller.newPasswordController,
                        isObscure: true,
                        isPassword: true,
                        onChanged: (value) {
                          changepasswordcontroller.checkPasswordsValid();
                        },
                      ),
                      const SizedBox(height: 21),
                      CustomTextFormField(
                        labelText: 'Confirm New Password',
                        hintText: 'Enter password',
                        controller: changepasswordcontroller
                            .newPasswordConfirmController,
                        isObscure: true,
                        isPassword: true,
                        onChanged: (value) {
                          changepasswordcontroller.checkPasswordsValid();
                        },
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          //_showCustomPopup(context);
                          //showDataAlert(context, 'asd');
                          // Get.dialog(
                          //     CustomDialog().success('Password Changed', () {
                          //   Get.back();
                          // }));
                          Get.to(() => ForgotPasswordPage());
                        },
                        child: Text(
                          'Forgot your password?',
                          style: TextStyle(
                              color: bgColor,
                              fontSize: 14,
                              fontFamily: 'D-DIN Exp',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 30),
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                              child: PrimaryButton(
                                colorButton: Colors.white,
                                borderSideColor: Colors.black,
                                text: 'Cancel',
                                borderRadiusSize: 30,
                              ),
                            ),
                            const SizedBox(width: 9),
                            Expanded(
                              child: PrimaryButton(
                                text: 'Save',
                                //isDisable: true,
                                isDisable: !changepasswordcontroller
                                    .isValidPasswords.value,
                                borderRadiusSize: 30,
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  changepasswordcontroller.createNewPassword();
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _showCustomPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopup(); // Gunakan widget custom popup di sini
      },
    );
  }

  void showDataAlert(BuildContext context, String data) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Title'),
              content: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Here content'),
                    Text('Password Changed'),
                    Text('Here content'),
                  ],
                ),
              ),
            ));
  }
}

class CustomPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //title: Text('Popup dengan Teks dan Tombol Tutup'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Ini adalah konten dari popup.'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Tutup popup saat tombol "Tutup" ditekan
            },
            child: Text('Tutup'),
          ),
        ],
      ),
    );
  }
}
