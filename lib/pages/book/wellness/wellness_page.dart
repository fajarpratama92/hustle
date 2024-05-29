import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/wellness/wellness_controller.dart';
import 'package:hustle_house_flutter/utils/widgets/location/pop_up_location_wellness.dart';

import '../../../utils/colors.dart';
import '../../../utils/widgets/filter_location.dart';
import '../../../utils/widgets/loading/loading.dart';
import '../recovery/detail/arg_recovery_detail.dart';
import '../recovery/detail/recovery_detail_page.dart';
import '../trainer/widget/item_recovery.dart';

class WellnessPage extends StatelessWidget {
  WellnessPage({super.key});

  final WellnessController controller = Get.put(WellnessController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WellnessController>(builder: (_) {
      return SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(14),
          child: Column(
            children: [
              FilterLocation(
                text: controller
                    .locationWellnessController.selectedLocationName.value,
                onTap: () {
                  controller.locationWellnessController.updatePopUpLocations();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [_content(), PopUpLocationWellness()],
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _content() {
    if (controller.message.isNotEmpty) {
      return Center(
        child: Text(
          controller.message.value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'D-DIN Exp',
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    if (controller.wellness.isEmpty) {
      return Center(
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/images/ic_no_class.svg",
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Wellness not found',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: gray,
                fontSize: 14,
                fontFamily: 'D-DIN Exp',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    }

    if (controller.isLoading.isTrue) {
      return GridView.builder(
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.848,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return const Loading(
            marginHorizontal: 0,
          );
        },
      );
    }

    return GridView.builder(
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.848,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: controller.wellness.length,
      itemBuilder: (context, index) {
        final recovery = controller.wellness[index];
        return ItemRecovery(
          recovery: recovery,
          onTap: () {
            Get.to(
                () => RecoveryDetailPage(
                      title: 'Wellness',
                    ),
                arguments: {
                  ArgRecoveryDetail.sessionId: recovery.sessionId,
                  ArgRecoveryDetail.sportClassId: recovery.id,
                  ArgRecoveryDetail.title: 'Wellness',
                });
          },
        );
      },
    );
  }
}
