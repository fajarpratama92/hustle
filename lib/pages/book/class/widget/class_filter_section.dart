import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/class/book_class_controller.dart';

import '../../../../utils/colors.dart';
import 'item_pop_up.dart';

class ClassFilterSection extends StatelessWidget {
  const ClassFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookClassController>();
    return GetBuilder<BookClassController>(builder: (_) {
      return Visibility(
        visible: controller.isPopUpLocations.isFalse,
        child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight:
                    Get.height < 800 ? Get.height / 2.3 : Get.height / 1.9,
              ),
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: controller.isPopUpClass.isTrue ? 5 : 0),
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: disableColor),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = controller.classes[index];
                      return ItemFilter(
                        location: item.name ?? '',
                        isCheck: controller.classSelected.contains(item.id),
                        onChanged: (value) {
                          controller.updateClassSelected(
                              item.id ?? 0, value ?? false);
                        },
                      );
                    },
                    itemCount: controller.classes.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 23,
                      );
                    },
                  ),
                ),
              ),
            ),
            secondChild: Container(),
            crossFadeState: controller.isPopUpClass.isTrue
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond),
      );
    });
  }
}
