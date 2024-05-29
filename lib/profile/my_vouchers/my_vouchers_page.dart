import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/my_vouchers/widget/vouchers_item.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';
import 'package:hustle_house_flutter/utils/colors.dart';

class MyVouchersPage extends StatelessWidget {
  MyVouchersPage({Key? key}) : super(key: key);

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var discountVoucher = controller.discountVoucher.value?.data!;
    var complimentaryVoucher = controller.complimentaryVoucher.value?.data!;
    bool isVoucherAvailable =
        discountVoucher!.isNotEmpty || complimentaryVoucher!.isNotEmpty;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Vouchers',
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
      body: Obx(
        () => Visibility(
          visible: isVoucherAvailable,
          replacement: Container(
            alignment: Alignment.center,
            width: Get.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/ic_no_voucher.svg",
                    height: 119,
                    width: 161.92,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'You don’t have any voucher',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: gray2,
                      fontSize: 14,
                      fontFamily: 'D-DIN Exp',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: controller.discountVoucher.value?.data?.isNotEmpty ??
                      false,
                  child: Container(
                      transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.only(
                          left: 14, right: 14, bottom: 1, top: 20),
                      child: const Text("Discounts",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'D-DIN Exp',
                            fontWeight: FontWeight.w700,
                          ))),
                ),
                if (controller.discountVoucher.value?.data?.isNotEmpty ?? false)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    child: Container(
                      height: controller.complimentaryVoucher.value?.data! != []
                          ? Get.height - 200
                          : Get.height / 2.6,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              primary: false,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller
                                  .getUniqueDiscountVouchers(
                                      controller.discountVoucher.value?.data!)
                                  .length,
                              itemBuilder: (context, index) {
                                final discountVouchers = controller
                                    .getUniqueDiscountVouchers(controller
                                        .discountVoucher.value?.data!)[index];
                                final voucherCount =
                                    controller.getDiscountVoucherCount(
                                        discountVouchers,
                                        controller
                                            .discountVoucher.value?.data!);
                                return MyVouchersItem(
                                  discountVoucher: discountVouchers,
                                  onTap: () {},
                                  isDiscount: true,
                                  totalVoucher: voucherCount,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 14,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Visibility(
                  visible:
                      controller.complimentaryVoucher.value?.data?.isNotEmpty ??
                          false,
                  child: Container(
                      transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                      padding: const EdgeInsets.only(top: 10),
                      margin: const EdgeInsets.only(
                          left: 14, right: 14, bottom: 4, top: 20),
                      child: const Text("Complimentary Passes",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'D-DIN Exp',
                            fontWeight: FontWeight.w700,
                          ))),
                ),
                if (controller.complimentaryVoucher.value?.data?.isNotEmpty ??
                    false)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    child: Container(
                      height: controller.discountVoucher.value?.data! != []
                          ? Get.height - 200
                          : Get.height / 2.6,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              primary: false,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller
                                  .getUniqueComplimentaryVouchers(controller
                                      .complimentaryVoucher.value?.data!)
                                  .length,
                              itemBuilder: (context, index) {
                                final complimentaryVouchers = controller
                                    .getUniqueComplimentaryVouchers(controller
                                        .complimentaryVoucher
                                        .value
                                        ?.data!)[index];
                                final voucherCount =
                                    controller.getComplimentaryVoucherCount(
                                        complimentaryVouchers,
                                        controller
                                            .complimentaryVoucher.value?.data!);
                                return MyVouchersItem(
                                  complimentaryVoucher: complimentaryVouchers,
                                  onTap: () {},
                                  isDiscount: false,
                                  totalVoucher: voucherCount,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 14,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
