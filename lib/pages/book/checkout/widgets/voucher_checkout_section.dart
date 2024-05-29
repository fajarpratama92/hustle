import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../../utils/colors.dart';
import '../../../voucher/argument_use_voucher.dart';
import '../../../voucher/use_vouceher_page.dart';

class VoucherCheckoutSection extends StatelessWidget {
  const VoucherCheckoutSection(
      {super.key,
      required this.route,
      required this.voucher,
      required this.category,
      this.locationID});

  final String route;
  final String voucher;
  final String category;
  final int? locationID;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 1, color: disableColor),
          bottom: BorderSide(width: 1, color: disableColor),
        ),
      ),
      child: InkWell(
        onTap: () {
          Get.to(() => UseVoucherPage(), arguments: {
            ArgumentUseVoucher.type: 2,
            ArgumentUseVoucher.currentRoute: route,
            ArgumentUseVoucher.usedVoucher: voucher,
            ArgumentUseVoucher.category: category,
            ArgumentUseVoucher.locationID: locationID
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Voucher',
              style: DDinExp.regular.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Text(
              (voucher.isNotEmpty) ? voucher : 'Choose a voucher',
              textAlign: TextAlign.right,
              style: DDinExp.regular.copyWith(
                color: (voucher.isNotEmpty) ? Colors.black : gray2,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.chevron_right_outlined)
          ],
        ),
      ),
    );
  }
}