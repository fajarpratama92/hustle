import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/register/register_controller.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/custom_text_form_field.dart';
import '../../utils/widgets/platform_button.dart';
import '../../utils/widgets/primary_button.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final RegisterController controller = Get.put(RegisterController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmationEmailController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmationPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: GetBuilder<RegisterController>(builder: (context) {
        return SafeArea(child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: SizedBox(
              height: height < 700 ? height + 100 : height,
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: -40,
                    child: SvgPicture.asset("assets/images/bg_login_top.svg"),
                  ),
                  Positioned(
                      left: 0,
                      top: 20,
                      child: IconButton(
                        icon: const Icon(
                          Icons.chevron_left_outlined,
                          size: 36,
                        ),
                        color: Colors.black,
                        onPressed: () {
                          Get.back();
                        },
                      )),
                  const Positioned(
                    left: 0,
                    right: 0,
                    top: 56,
                    child: Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 14,
                    right: 14,
                    top: 130,
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            labelText: 'Email',
                            hintText: 'Enter email',
                            isRequired: true,
                            isDisableError: true,
                            controller: emailController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return '';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              controller.changeStateFirstReg(
                                  _formKey.currentState?.validate() ?? false);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                            labelText: 'Confirm Email',
                            hintText: 'Enter email',
                            isRequired: true,
                            isDisableError: true,
                            controller: confirmationEmailController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return '';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              controller.changeStateFirstReg(
                                  _formKey.currentState?.validate() ?? false);
                            },
                          ),
                          Visibility(
                              visible: controller.isErrorConfirmEmail.isTrue,
                              child: Text(
                                'Email not match',
                                style: TextStyle(
                                  color: red,
                                  fontSize: 14,
                                  fontFamily: 'D-DIN Exp',
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                            labelText: 'Password',
                            hintText: 'Enter password',
                            isRequired: true,
                            isObscure: true,
                            isPassword: true,
                            isDisableError: true,
                            controller: passwordController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return '';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              controller.changeStateFirstReg(
                                  _formKey.currentState?.validate() ?? false);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                            labelText: 'Confirm Password',
                            hintText: 'Enter password',
                            isRequired: true,
                            isObscure: true,
                            isPassword: true,
                            isDisableError: true,
                            controller: confirmationPasswordController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return '';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              controller.changeStateFirstReg(
                                  _formKey.currentState?.validate() ?? false);
                            },
                          ),
                          Visibility(
                              visible:
                                  controller.isErrorConfirmPassword.isTrue,
                              child: Text(
                                'Password not match',
                                style: TextStyle(
                                  color: red,
                                  fontSize: 14,
                                  fontFamily: 'D-DIN Exp',
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          Visibility(
                            visible: controller.isLoading.isFalse,
                            child: PrimaryButton(
                              text: 'Continue',
                              isDisable:
                                  controller.isValidateFirstReg.isFalse,
                              onPressed: () {
                                controller.changeErrorConfirmation(
                                    emailController.text !=
                                        confirmationEmailController.text,
                                    passwordController.text !=
                                        confirmationPasswordController.text);

                                if (controller.isErrorConfirmEmail.isFalse &&
                                    controller
                                        .isErrorConfirmPassword.isFalse) {
                                  controller.getEmailPassword(
                                      emailController.text,
                                      passwordController.text);
                                  controller.checkEmail(emailController.text);
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
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: PlatformButton(
                              text: 'Continue with Facebook',
                              icon: 'assets/images/ic_facebook.svg',
                              onPressed: () {
                                controller.handleRegisterFacebook();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Center(
                            child: PlatformButton(
                              text: 'Sign Up with Google',
                              icon: 'assets/images/ic_google.svg',
                              colorButton: Colors.white,
                              borderSideColor: Colors.white,
                              textColor: Colors.black.withOpacity(0.54),
                              onPressed: () {
                                controller.handleRegisterGoogle();
                              },
                            ),
                          ),
                          if (Platform.isIOS) ...[
                            const SizedBox(
                              height: 14,
                            ),
                            Center(
                              child: PlatformButton(
                                text: 'Continue with Apple',
                                icon: 'assets/images/ic_apple.svg',
                                colorButton: Colors.black,
                                borderSideColor: Colors.black,
                                textColor: Colors.white,
                                onPressed: () {
                                  controller.handleRegisterApple();
                                },
                              ),
                            ),
                          ],
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'D-DIN Exp',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Text(
                                  'Sign In',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'D-DIN Exp',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 20,
                    child:
                        SvgPicture.asset("assets/images/bg_login_bottom.svg"),
                  ),
                ],
              ),
            ),
          );
        }));
      }),
    );
  }
}
