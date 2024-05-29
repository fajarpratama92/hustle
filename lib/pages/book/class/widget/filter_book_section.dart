import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../../utils/colors.dart';
import '../book_class_controller.dart';
import 'pop_up_filter.dart';

class FilterBookSection extends StatelessWidget {
  const FilterBookSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookClassController>();
    return GetBuilder<BookClassController>(builder: (_) {
      return InkWell(
        onTap: () {
          Get.dialog(PopUpFilter());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          margin:
              const EdgeInsets.only(bottom: 20, top: 14, left: 14, right: 14),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: disableColor),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Filter',
                style: DDinExp.regular.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 10),
              Visibility(
                visible: controller.totalFilter > 0,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: ShapeDecoration(
                            color: primaryColor,
                            shape: const OvalBorder(),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          controller.totalFilter.value.toString(),
                          style: DDinExp.regular.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SvgPicture.asset("assets/images/ic_filter.svg")
            ],
          ),
        ),
      );
    });
  }
}
