import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/discount_vouchers.dart';
import 'package:hustle_house_flutter/model/complimentary_vouchers.dart'
    as complimentary;
import 'package:intl/intl.dart';

import '../../../../utils/colors.dart';

class MyVouchersItem extends StatelessWidget {
  const MyVouchersItem({
    super.key,
    required this.onTap,
    this.discountVoucher,
    this.complimentaryVoucher,
    this.width,
    this.isSelected,
    required this.isDiscount,
    this.totalVoucher,
  });

  final VoidCallback onTap;
  final Datum? discountVoucher;
  final complimentary.Datum? complimentaryVoucher;
  final double? width;
  final bool? isSelected;
  final bool isDiscount;
  final int? totalVoucher;

  @override
  Widget build(BuildContext context) {
    String? discountExpired = DateFormat('dd MMMM yyyy')
        .format(discountVoucher?.expired ?? DateTime(2000));
    String? complimentaryExpired = DateFormat('dd MMMM yyyy')
        .format(complimentaryVoucher?.expired ?? DateTime(2000));
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: width ?? Get.width / 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFFE6E6E6)),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    isDiscount
                        ? discountVoucher!.rewardVoucher?.name ?? ''
                        : complimentaryVoucher!.rewardVoucher?.name ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'D-DIN Exp',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/ic_alert.svg",
                        ),
                        if(!isDiscount)
                        const SizedBox(width: 5),
                        Text(
                          isDiscount
                              ? discountVoucher!.rewardVoucher?.description ??
                                  ''
                              : complimentaryVoucher!
                                      .rewardVoucher?.description ??
                                  '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: gray,
                            fontSize: 12,
                            fontFamily: 'D-DIN Exp',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/ic_valid_date.svg",
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Valid until: ${isDiscount ? discountExpired : complimentaryExpired}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: gray,
                            fontSize: 12,
                            fontFamily: 'D-DIN Exp',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 30,
            bottom: 30,
            child: Container(
                width: 20,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      right: BorderSide(color: Color(0xFFE6E6E6), width: 0),
                      left: BorderSide(color: Color(0xFFE6E6E6)),
                      top: BorderSide(color: Color(0xFFE6E6E6)),
                      bottom: BorderSide(color: Color(0xFFE6E6E6))),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      topLeft: Radius.circular(100)),
                )),
          ),
          Positioned(
            left: 0,
            top: 30,
            bottom: 30,
            child: Container(
                width: 20,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      right: BorderSide(color: Color(0xFFE6E6E6)),
                      left: BorderSide(color: Color(0xFFE6E6E6), width: 0),
                      top: BorderSide(color: Color(0xFFE6E6E6)),
                      bottom: BorderSide(color: Color(0xFFE6E6E6))),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(100),
                      topRight: Radius.circular(100)),
                )),
          ),
          Visibility(
            visible: (totalVoucher ?? 0) > 1,
            child: Positioned(
              right: 30,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: ShapeDecoration(
                  color: primaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
                child: Text(
                  'x$totalVoucher',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'D-DIN Exp',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
