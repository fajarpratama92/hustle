import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/trainer_detail_controller.dart';

class AboutTrainerSection extends StatelessWidget {
  const AboutTrainerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrainerDetailController>();
    return GetBuilder<TrainerDetailController>(builder: (_) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'About',
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
            Text(
              controller.trainer.value?.about ?? 'No Information Available',
              maxLines: controller.isReadMore.isTrue ? null : 6,
              overflow:
                  controller.isReadMore.isTrue ? null : TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'D-DIN Exp',
                fontWeight: FontWeight.w400,
              ),
            ),
            Visibility(
              visible: (controller.trainer.value?.about?.length ?? 0) > 300,
              child: const SizedBox(
                height: 14,
              ),
            ),
            Visibility(
              visible: (controller.trainer.value?.about?.length ?? 0) > 300,
              child: InkWell(
                onTap: () {
                  controller.updateReadMore();
                },
                child: Text(
                  controller.isReadMore.isTrue ? 'Read less' : 'Read more',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'D-DIN Exp',
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
