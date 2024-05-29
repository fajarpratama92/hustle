import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/purchase/credit/credit_controller.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/list_loading.dart';

import 'credit_price_guide.dart';
import 'expanded_text_widget.dart';

class PriceGuideSection extends StatelessWidget {
  PriceGuideSection({super.key});

  final controller = Get.find<CreditController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -10.0, 0.0),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 10, top: 10),
      child: ExpandedTextWidget(
        text: "Credits Price Guide ",
        fontColor: Colors.black,
        children: [_priceGuide()],
      ),
    );
  }

  Widget _priceGuide() {
    if (controller.isLoadingGuide.isTrue) {
      return const ListLoading(
        height: 67,
        marginHorizontal: 0,
      );
    }
    return ListView.builder(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.priceGuide.length,
        itemBuilder: (context, index) {
          final priceGuide = controller.priceGuide[index];
          return CreditPriceGuide(
            priceGuide: priceGuide,
          );
        });
  }
}
