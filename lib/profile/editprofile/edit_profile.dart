import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/editprofile/widget/picker_bottom_sheet.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/custom_text_form_field.dart';
import '../../utils/widgets/date_birth_edit_text_field.dart';
import '../../utils/widgets/empty/empty_photo.dart';
import '../../utils/widgets/gender_dropdown.dart';
import '../../utils/widgets/phone_number_edit_text_field.dart';
import '../../utils/widgets/primary_button.dart';
import '../profile_controller.dart';
import 'edit_profile_controller.dart';

class EditProfilePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final EditProfileController controller = Get.put(EditProfileController());
  final ProfileController profileController = Get.put(ProfileController());
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emergencyContactController =
      TextEditingController();
  final TextEditingController emergencyNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isGenderExist =
        profileController.userProfile.value?.member?.gender != '';
    bool? isAddressExist =
        profileController.userProfile.value?.member?.address?.isNotEmpty;
    bool? isEmergencyNameExist =
        profileController.userProfile.value?.member?.emergencyName?.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'D-DIN Exp',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        toolbarHeight: kToolbarHeight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_outlined,
            size: 28,
          ),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight / 4),
          child: Divider(thickness: 10, color: gray1),
        ),
      ),
      body: GetBuilder<EditProfileController>(builder: (_) {
        return Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: CachedNetworkImage(
                          height: 120,
                          width: 120,
                          imageUrl: profileController
                                  .userProfile.value?.member?.imageUrl ??
                              '',
                          placeholder: (context, url) => SizedBox(
                              width: 120,
                              height: 120,
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              )),
                          errorWidget: (context, url, error) {
                            final firstName = profileController
                                    .userProfile.value?.firstName?[0] ??
                                '';
                            final lastName = profileController
                                    .userProfile.value?.lastName?[0] ??
                                '';
                            return Center(
                                child: EmptyPhoto(
                              initialName: '$firstName$lastName',
                              sizePhoto: 120,
                              sizeFont: 40,
                            ));
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Change Profile Picture',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'D-DIN Exp',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Get.bottomSheet(
                                ImagePickerBottomSheet(),
                                ignoreSafeArea: false,
                                isScrollControlled: true,
                              );
                            },
                            child: SvgPicture.asset(
                              "assets/images/ic_edit.svg",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  height: 44,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFFE6E6E6)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: SvgPicture.asset(profileController.loginTypeIcon(
                            profileController.userProfile.value?.loginType ??
                                '')),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        profileController.userProfile.value?.email ?? '',
                        style: const TextStyle(
                          color: Color(0xFF9D9D9D),
                          fontSize: 14,
                          fontFamily: 'D-DIN Exp',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.only(right: 14),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          labelText: 'First Name',
                          hintText:
                              profileController.userProfile.value?.firstName ??
                                  "Enter first name",
                          controller: firstNameController,
                          isRequired: false,
                          isDisableError: true,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            labelText: 'Last Name',
                            hintText:
                                profileController.userProfile.value?.lastName ??
                                    'Enter last name',
                            controller: lastNameController,
                            isRequired: false,
                            isDisableError: true,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        PhoneNumberEditTextField(
                          number: controller.number,
                          controller: phoneController,
                          onPhoneChanged: (value) {},
                          isEmergency: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DateBirthEditTextField(
                          day: controller.day?.value,
                          month: controller.month.value,
                          year: controller.year.value,
                          isError: controller.day?.value.isEmpty,
                          onPressed: () async {
                            DateTime? picked = await showDatePicker(
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: primaryColor,
                                        onPrimary: Colors.black,
                                        onSurface: Colors.black,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: primaryDarkColor2,
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                                context: context,
                                initialDate: DateTime(2000, 1),
                                firstDate: DateTime(1965, 1),
                                lastDate: DateTime(2025));

                            controller.getPicked(picked);
                          },
                        ),
                        GenderDropdown(
                          label: 'Gender',
                          genders: const ["Male", "Female"],
                          onGenderChanged: (String) {},
                          hint: isGenderExist
                              ? profileController
                                  .userProfile.value?.member?.gender
                              : 'Choose your gender',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          labelText: 'Home Address',
                          hintText: isAddressExist ?? false
                              ? profileController
                                  .userProfile.value?.member?.address
                              : 'Enter address',
                          controller: addressController,
                          isRequired: false,
                          isDisableError: true,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          labelText: 'Emergency Contact Name',
                          hintText: isEmergencyNameExist ?? false
                              ? profileController
                                  .userProfile.value?.member?.emergencyName
                              : 'Enter name',
                          controller: emergencyContactController,
                          isRequired: false,
                          isDisableError: true,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        PhoneNumberEditTextField(
                          number: controller.number,
                          controller: emergencyNumberController,
                          onPhoneChanged: (value) {},
                          isEmergency: true,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                borderSideColor: Colors.black,
                                colorButton: Colors.white,
                                elevation: 0,
                                text: 'Cancel',
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Visibility(
                                visible: controller.isLoading.isFalse,
                                child: PrimaryButton(
                                  text: 'Save',
                                  isDisable: /*controller.isDisable()*/ false,
                                  onPressed: () {
                                    controller.editProfile(
                                      firstName:
                                          firstNameController.value.text == ''
                                              ? profileController
                                                  .userProfile.value?.firstName
                                              : firstNameController.value.text,
                                      lastName:
                                          lastNameController.value.text == ''
                                              ? profileController
                                                  .userProfile.value?.lastName
                                              : lastNameController.value.text,
                                      phone: phoneController.value.text == ''
                                          ? profileController
                                              .userProfile.value?.member?.phone
                                          : phoneController.value.text,
                                      gender: controller.gender.value == ''
                                          ? profileController
                                              .userProfile.value?.member?.gender
                                          : controller.gender.value,
                                      address:
                                          addressController.value.text == ''
                                              ? profileController.userProfile
                                                  .value?.member?.address
                                              : addressController.value.text,
                                      emergencyName: emergencyContactController
                                                  .value.text ==
                                              ''
                                          ? profileController.userProfile.value
                                              ?.member?.emergencyName
                                          : emergencyContactController
                                              .value.text,
                                      emergencyPhone: emergencyNumberController
                                                  .value.text ==
                                              ''
                                          ? profileController.userProfile.value
                                              ?.member?.emergencyPhone
                                          : emergencyNumberController
                                              .value.text,
                                    );
                                    controller.update();
                                  },
                                ),
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
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
