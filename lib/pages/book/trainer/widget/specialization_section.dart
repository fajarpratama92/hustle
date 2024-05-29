import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/trainer_detail_controller.dart';

import 'item_specialization.dart';

class SpecializationSection extends StatelessWidget {
  SpecializationSection({super.key});

  final controller = Get.find<TrainerDetailController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrainerDetailController>(builder: (_) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Specialization',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'D-DIN Exp',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _specialization(),
          ],
        ),
      );
    });
  }

  Widget _specialization() {
    if (controller.trainer.value?.teacherSpecialization?.isEmpty ?? false) {
      return const Text('No Specialization',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'D-DIN Exp',
            fontWeight: FontWeight.w400,
          ));
    }
    return SizedBox(
        height: 31,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final item = controller.trainer.value?.teacherSpecialization?[index]
                .teacherSpecializationName?.name;
            return ItemSpecialization(name: item ?? '');
          },
          itemCount:
              controller.trainer.value?.teacherSpecialization?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 10,
            );
          },
        ));
  }
}
