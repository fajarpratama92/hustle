import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/purchase/credit/credit_controller.dart';
import 'package:hustle_house_flutter/purchase/widget/counter.dart';
import 'package:hustle_house_flutter/purchase/widget/first_time_section.dart';
import 'package:hustle_house_flutter/purchase/widget/price_guide_section.dart';
import 'package:hustle_house_flutter/utils/widgets/monthly/monthly_class_section.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';

import '../../utils/colors.dart';

class CreditTabPage extends StatelessWidget {
  CreditTabPage({super.key});

  final controller = Get.put(CreditController());

  @override
  Widget build(BuildContext context) {
    if (controller.packageFirstTimer.isNotEmpty) {
      controller.getPackage();
    }
    return GetBuilder<CreditController>(builder: (_) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FirstTimeSection(),
            const SizedBox(
              height: 14,
            ),
            MonthlyClassSection(
              isLoading: controller.isLoading.isTrue,
              title: controller.title.value,
              description: controller.description.value,
              isPurchase: true,
            ),
            Divider(
              color: disableColor,
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                "Buy Credit(s)",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ItemCounter(),
            PriceGuideSection(),
            _buttonOrderCredit()
          ],
        ),
      );
    });
  }

  Widget _buttonOrderCredit() {
    return Container(
        transform: Matrix4.translationValues(0.0, -10.0, 0.0),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(left: 14, right: 14, bottom: 10, top: 10),
        child: PrimaryButton(
          isDisable: controller.currentValue.value <= 0,
          text: "Confirm",
          elevation: 0,
          isLoading: controller.isLoadingCredit.isTrue,
          onPressed: () {
            controller.orderCredit();
          },
        ));
  }
}
