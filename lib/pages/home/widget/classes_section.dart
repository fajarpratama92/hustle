import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';
import 'package:hustle_house_flutter/pages/home/widget/label_menu.dart';
import 'package:hustle_house_flutter/pages/main/main_controller.dart';

import '../../../utils/home_bindings.dart';
import '../../../utils/widgets/loading/loading.dart';
import '../../bookingclass/class/class_page.dart';
import '../../bookingclass/class_schedule/class_schedule_page.dart';
import 'item_class.dart';

class ClassesSection extends StatelessWidget {
  const ClassesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final mainController = Get.find<MainController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LabelMenu(
          menu: 'CLASSES',
          onTap: () {
            mainController.updatePages(const ClassPage());
            mainController.updateIndex(1);
          },
        ),
        GetBuilder<HomeController>(builder: (_) {
          if (controller.isLoadingClasses.isTrue) {
            return const Loading(
              height: 318,
            );
          }
          return Container(
            height: 318,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final sportClass = controller.classes[index];
                  return ItemClass(
                    sportClass: sportClass,
                    onTap: () {
                      Get.to(() => ClassSchedulePage(),
                          arguments: sportClass, binding: HomeBindings());
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                itemCount: controller.classes.length),
          );
        }),
      ],
    );
  }
}
