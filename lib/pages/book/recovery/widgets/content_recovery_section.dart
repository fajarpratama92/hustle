import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/recovery/recovery_controller.dart';
import 'package:hustle_house_flutter/utils/widgets/empty/empty_class.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/grid_loading.dart';
import 'package:hustle_house_flutter/utils/widgets/text/text_description.dart';

import '../../trainer/widget/item_recovery.dart';
import '../detail/arg_recovery_detail.dart';
import '../detail/recovery_detail_page.dart';

class ContentRecoverySection extends StatelessWidget {
  const ContentRecoverySection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecoveryController>();

    return GetBuilder<RecoveryController>(builder: (context) {
      if (controller.message.isNotEmpty) {
        return Center(
          child: TextDescription(
            description: controller.message.value,
          ),
        );
      }

      if (controller.recoveries.isEmpty) {
        return const EmptyClass(
          text: 'Recovery not found',
        );
      }

      if (controller.isLoading.isTrue) {
        return const GridLoading(
          childAspectRatio: 0.83,
          itemCount: 6,
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
        itemCount: controller.recoveries.length,
        itemBuilder: (context, index) {
          final recovery = controller.recoveries[index];
          return ItemRecovery(
            recovery: recovery,
            onTap: () {
              Get.to(
                  () => RecoveryDetailPage(
                        title: 'Recovery',
                      ),
                  arguments: {
                    ArgRecoveryDetail.sessionId: recovery.sessionId,
                    ArgRecoveryDetail.sportClassId: recovery.id,
                    ArgRecoveryDetail.title: 'Recovery'
                  });
            },
          );
        },
      );
    });
  }
}
