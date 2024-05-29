import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/trainer_detail_controller.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/widgets/custom_dialog.dart';
import '../../../../utils/widgets/dialog/cancel_dialog.dart';
import '../../../../utils/widgets/floating_button.dart';
import '../book/book_pt_page.dart';

class ButtonTrainerSection extends StatelessWidget {
  const ButtonTrainerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrainerDetailController>();
    bool isFromBookingHistory = Get.previousRoute == '/BookingHistoryPage';
    return GetBuilder<TrainerDetailController>(builder: (_) {
      if (controller.isRateClass()) {
        return FloatingButton(
          text: "Rate Class",
          onPressed: () {
            Get.dialog(CustomDialog().rating(rate: (rate, comment) {
              controller.reviewTrainer(rate: '$rate', comment: comment);
            }));
          },
        );
      }
      if (controller.isCancel.isTrue) {
        return FloatingButton(
          text: 'Cancel',
          colorButton: Colors.white,
          textColor: red,
          borderColor: red,
          onPressed: () {
            Get.dialog(CancelDialog(
                title: 'Cancel Class',
                subTitle: controller.isReturnCredit.isFalse
                    ? 'Are you sure you want to cancel this class?'
                    : 'Are you sure you want to cancel this class? Your credit will be returned.',
                message: controller.isReturnCredit.isFalse
                    ? 'Your credit will not be returned'
                    : '',
                onTap: () {
                  controller.cancelBook();
                }));
          },
        );
      }
      return Visibility(
        visible: !controller.isCancelled() && !isFromBookingHistory,
        child: FloatingButton(
          text: 'Check Availability',
          onPressed: () {
            Get.to(
                () => BookPTPage(
                      trainer:
                          '${controller.trainer.value?.firstName} ${controller.trainer.value?.lastName}',
                      price: controller.trainer.value?.price.toString() ?? '0',
                    ),
                arguments: [controller.trainer.value?.id]);
          },
        ),
      );
    });
  }
}
