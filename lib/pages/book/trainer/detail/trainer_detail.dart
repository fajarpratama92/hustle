import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/arg_trainer_detail.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/trainer_detail_controller.dart';
import 'package:hustle_house_flutter/pages/book/trainer/widget/about_trainer_section.dart';
import 'package:hustle_house_flutter/pages/book/trainer/widget/button_trainer_section.dart';
import 'package:hustle_house_flutter/pages/book/trainer/widget/date_trainer_section.dart';
import 'package:hustle_house_flutter/pages/book/trainer/widget/specialization_section.dart';
import 'package:hustle_house_flutter/pages/book/trainer/widget/trainer_duration_section.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/widgets/detail/cancelled_label_detail_section.dart';
import '../../../../utils/widgets/loading/loading_detail.dart';
import '../../../../utils/widgets/review_section.dart';
import '../widget/photo_trainer_section.dart';

class TrainerDetail extends StatelessWidget {
  TrainerDetail({super.key});

  final TrainerDetailController controller = Get.put(TrainerDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Trainer Details',
      ),
      body: GetBuilder<TrainerDetailController>(builder: (_) {
        if (controller.isLoading.isTrue) {
          return const LoadingDetail();
        }
        final trainer = controller.trainer.value;
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const PhotoTrainerSection(),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        '${controller.trainer.value?.firstName} ${controller.trainer.value?.lastName}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Oswald',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const DateTrainerSection(),
                    TrainerDurationSection(trainer: trainer),
                    Divider(
                      color: gray1,
                      thickness: 1,
                    ),
                    SpecializationSection(),
                    const AboutTrainerSection(),
                    Divider(
                      color: gray1,
                      thickness: 1,
                      height: 40,
                    ),
                    ReviewSection(
                      isVisible: controller.comments.isNotEmpty &&
                          !controller.isCancelled(),
                      review: controller.review.value,
                      comment: controller.comments.isNotEmpty
                          ? controller.comments[0]
                          : null,
                      id: controller.arguments[ArgTrainerDetail.teacherId]
                          .toString(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CancelledLabelDetailSection(
                        isVisible: controller.isCancelled())
                  ],
                ),
              ),
            ),
            const ButtonTrainerSection()
          ],
        );
      }),
    );
  }
}
