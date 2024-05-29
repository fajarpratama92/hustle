import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/recovery/detail/recovery_detail_controller.dart';

import '../../../../../utils/api/endpoint.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/widgets/custom_dialog.dart';
import '../../../../../utils/widgets/dialog/cancel_dialog.dart';
import '../../../../../utils/widgets/floating_button.dart';
import '../../book/argument_book_recovery.dart';
import '../../book/book_recovery_page.dart';

class ButtonRecoverySection extends StatelessWidget {
  const ButtonRecoverySection(
      {super.key, required this.title, required this.name});

  final String title;
  final String name;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecoveryDetailController>();
    return GetBuilder<RecoveryDetailController>(builder: (_) {
      if (controller.isShowButtonRate()) {
        return FloatingButton(
          text: "Rate Class",
          onPressed: () {
            Get.dialog(CustomDialog().rating(rate: (rate, comment) {
              controller.reviewRecovery(rate: '$rate', comment: comment);
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
        visible: controller.isShowButtonAvailability(),
        child: FloatingButton(
          text: 'Check Availability',
          onPressed: () {
            Get.to(
                () => BookRecoveryPage(
                      name: name,
                      title: title,
                    ),
                arguments: {
                  ArgumentBookRecovery.sportClassId:
                      controller.recovery.value?.sportsClassId,
                  ArgumentBookRecovery.locationId:
                      controller.recovery.value?.locationId,
                  ArgumentBookRecovery.endpoint:
                      title.toLowerCase().contains('recovery')
                          ? Endpoint.selectedTimeRecovery
                          : Endpoint.selectedTimeWellness,
                  ArgumentBookRecovery.title: title,
                  ArgumentBookRecovery.price: controller.recovery.value?.price
                });
          },
        ),
      );
    });
  }
}
