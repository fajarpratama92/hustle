import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/bookingclass/class/class_type_controller.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/list_loading.dart';

import '../../../../utils/home_bindings.dart';
import '../../class_schedule/class_schedule_page.dart';
import 'item_list_class.dart';

class ClassSection extends StatelessWidget {
  const ClassSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClassTypeController>();
    return GetBuilder<ClassTypeController>(builder: (_) {
      if (controller.isLoadingBanner.isTrue) {
        return const ListLoading();
      }
      return ListView.separated(
        itemCount: controller.classes.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final sportClass = controller.classes[index];
          return ItemListClass(
            sportClass: sportClass,
            onTap: () {
              Get.to(() => ClassSchedulePage(),
                  arguments: sportClass, binding: HomeBindings());
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 14,
          );
        },
      );
    });
  }
}
