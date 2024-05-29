import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/changepassword/changepassword.dart';
import 'package:hustle_house_flutter/pages/membershipcard/membershipcard.dart';
import 'package:hustle_house_flutter/pages/purchaselist/purchase_list_page.dart';
import 'package:hustle_house_flutter/pages/termconditions/term_conditions_page.dart';
import 'package:hustle_house_flutter/profile/editprofile/edit_profile.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/purchase_history_page.dart';
import 'package:hustle_house_flutter/profile/upcomingclass/upcoming_class_page.dart';
import 'package:hustle_house_flutter/profile/widget/profile_button.dart';

import '../pages/refcode/referralcode.dart';
import '../utils/colors.dart';
import '../utils/extension/string.dart';
import '../utils/widgets/custom_app_bar.dart';
import '../utils/widgets/custom_dialog.dart';
import '../utils/widgets/empty/empty_photo.dart';
import 'bookinghistory/booking_history_page.dart';
import 'editprofile/edit_profile_controller.dart';
import 'my_vouchers/my_vouchers_page.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    controller
      ..getBookingHistoryCancelled()
      ..getBookingHistoryCompleted()
      ..getUpcomingClass()
      ..getUserProfile()
      ..fetchMembershipCodeFromApi()
      ..getCreditValidHistory()
      ..getPackageHistory()
      ..getVoucherHistory()
      ..getAvailableComplimentaryVoucher()
      ..getTotalPurchaseList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Profile',
        isNoLeading: true,
      ),
      body: GetBuilder<ProfileController>(builder: (context) {
        return Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                _profile(),
                _status(),
                _credits(),
                _activity(),
                _general(),
                Divider(
                  color: disableColor,
                  thickness: 1,
                ),
                _account()
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _profile() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      margin: const EdgeInsets.only(right: 14, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 14, right: 14, bottom: 10, top: 10),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: CachedNetworkImage(
                  height: 50,
                  width: 50,
                  imageUrl:
                      controller.userProfile.value?.member?.imageUrl ?? '',
                  placeholder: (context, url) => SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      )),
                  errorWidget: (context, url, error) {
                    final firstName =
                        controller.userProfile.value?.firstName?[0] ?? '';
                    final lastName =
                        controller.userProfile.value?.lastName?[0] ?? '';
                    return Center(
                        child: EmptyPhoto(
                      initialName: '$firstName$lastName',
                    ));
                  },
                  fit: BoxFit.cover,
                )),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${controller.userProfile.value?.firstName} ${controller.userProfile.value?.lastName}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "${controller.userProfile.value?.email}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              )
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Get.to(
                () => EditProfilePage(),
              );
            },
            child: SvgPicture.asset(
              "assets/images/ic_edit_outline.svg",
            ),
          ),
        ],
      ),
    );
  }

  Widget _status() {
    final activeSubscribe = controller.activeSubscribe.isNotEmpty
        ? controller.activeSubscribe[0]
        : null;
    return Visibility(
      visible: activeSubscribe != null,
      child: Container(
        transform: Matrix4.translationValues(0.0, -10.0, 0.0),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(left: 14, right: 14, bottom: 10, top: 10),
        decoration: BoxDecoration(
          color: _bgColor(activeSubscribe?.anotherName ?? ''),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Text(
                activeSubscribe?.anotherName ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                "Valid Until: ${activeSubscribe?.expired?.formatDate(format: 'dd-MM-yyyy')}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _credits() {
    return Container(
      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 1, top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor, // inner circle color
                      ),
                      child: SvgPicture.asset(
                        "assets/images/ic_credit.svg",
                        height: 24,
                        width: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Credits:',
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
                    Text(
                      controller.userProfile.value?.member?.remainingCredit
                              .toString() ??
                          "0",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'D-DIN Exp',
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor, // inner circle color
                      ),
                      child: SvgPicture.asset(
                        "assets/images/ic_award.svg",
                        height: 24,
                        width: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Points:',
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
                    Text(
                      controller.userProfile.value?.member?.rewardPoints
                              .toString() ??
                          "0",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'D-DIN Exp',
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _activity() {
    int sumPurchase = int.parse(
            controller.creditValidHistory.value?.data!.total.toString() ??
                '0') +
        int.parse(
            controller.creditExpiredHistory.value?.total.toString() ?? '0') +
        (controller
            .getUniqueVouchers(controller.voucherHistory.value?.data!)
            .length) +
        int.parse(controller.packageHistory.value?.total.toString() ?? '0');
    int sumHistory = int.parse(
            controller.bookingHistoryCompleted.value?.total.toString() ?? '0') +
        int.parse(
            controller.bookingHistoryCancelled.value?.total.toString() ?? '0');
    num sumVoucher = (controller.discountVoucher.value?.data?.length ?? 0) +
        (controller.complimentaryVoucher.value?.data!.length as num);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: const Text(
            'Activity',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'D-DIN Exp',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ProfileButton(
          svgAsset: "assets/images/ic_book_star.svg",
          text: 'Upcoming Classes',
          hasCountLabel: true,
          numbers: (controller.upcomingClass.value?.active?.length).toString(),
          onPressed: () {
            Get.to(() => const UpcomingClassPage());
          },
        ),
        ProfileButton(
          svgAsset: "assets/images/ic_calendar.svg",
          text: 'Booking History',
          hasCountLabel: true,
          numbers: sumHistory.toString(),
          topMargins: 10,
          onPressed: () {
            Get.to(() => BookingHistoryPage());
          },
        ),
        ProfileButton(
          svgAsset: "assets/images/ic_purchase_history.svg",
          text: 'Purchase History',
          hasCountLabel: true,
          numbers: sumPurchase.toString(),
          topMargins: 10,
          onPressed: () {
            controller.getCreditValidHistory();
            controller.getCreditExpiredHistory();
            Get.to(() => PurchaseHistoryPage());
          },
        ),
        ProfileButton(
          svgAsset: "assets/images/ic_purchase_list.svg",
          text: 'Purchase List',
          hasCountLabel: true,
          numbers: controller.totalPurchaseList.value.toString(),
          topMargins: 10,
          onPressed: () {
            Get.to(() => const PurchaseListPage());
          },
        ),
        ProfileButton(
          svgAsset: "assets/images/ic_coupon.svg",
          text: 'My Vouchers',
          hasCountLabel: true,
          numbers: sumVoucher.toString(),
          topMargins: 10,
          onPressed: () {
            Get.to(() => MyVouchersPage());
          },
        ),
      ],
    );
  }

  Widget _general() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: const Text(
            'General',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'D-DIN Exp',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ProfileButton(
          svgAsset: "assets/images/ic_card.svg",
          text: 'Proof of Hustlers',
          color: controller.isActive.value == 0 ? disableColor : Colors.white,
          onPressed: () {
            controller.isActive.value != 0
                ? Get.to(() => MembershipCardPage())
                : '';
          },
        ),
        ProfileButton(
          svgAsset: "assets/images/ic_reward.svg",
          text: 'Refer a Friend, Get a Reward',
          topMargins: 10,
          onPressed: () {
            Get.to(() => ReferralCodePage());
          },
        ),
        Visibility(
          visible: controller.isShowChangePassword,
          child: ProfileButton(
            svgAsset: "assets/images/ic_edit.svg",
            text: 'Change Password',
            topMargins: 10,
            onPressed: () {
              Get.to(() => ChangePasswordPage());
            },
          ),
        ),
        ProfileButton(
          svgAsset: "assets/images/ic_tnc.svg",
          text: 'Terms & Conditions',
          topMargins: 10,
          onPressed: () {
            Get.to(() => TermsConditionsPage());
          },
        ),
      ],
    );
  }

  Widget _account() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileButton(
          svgAsset: "assets/images/ic_log_out.svg",
          text: 'Log Out',
          onPressed: () => Get.dialog(
            CustomDialog().alert(
              'Log Out',
              'Are you sure you want to log out?',
              () {
                Get.back();
              },
              () {
                controller.logout();
              },
            ),
          ),
        ),
        ProfileButton(
          svgAsset: "assets/images/ic_trash.svg",
          text: 'Delete Account',
          topMargins: 10,
          onPressed: () => Get.dialog(
            CustomDialog().alert('Delete Account',
                'Are you sure you want to delete your account?', () {
              Get.back();
            }, () {
              controller.deleteAccount();
            },
                message:
                    "Your credits and points will be lost. This action cannot be reverted."),
          ),
        )
      ],
    );
  }

  Color _bgColor(String name) {
    bool isAllAccess = name.toLowerCase().contains('class + recovery') ||
        name.toLowerCase().contains('all access');
    if (isAllAccess) {
      return const Color(0xFFD4AF38);
    }
    return const Color(0xFF4169E1);
  }
}
