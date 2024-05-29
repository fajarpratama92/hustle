import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/bookingclass/class_schedule/class_schedule_section.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';
import 'package:hustle_house_flutter/utils/widgets/filter_location.dart';
import 'package:hustle_house_flutter/utils/widgets/location/pop_up_location.dart';
import 'package:hustle_house_flutter/utils/widgets/text/text_title.dart';
import 'package:intl/intl.dart';

import '../../../utils/widgets/text/text_month.dart';
import '../../book/class/widget/item_date.dart';
import 'class_schedule_controller.dart';

class ClassSchedulePage extends StatelessWidget {
  ClassSchedulePage({super.key});

  final ClassScheduleController controller =
      Get.find<ClassScheduleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Schedule',
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<ClassScheduleController>(builder: (_) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextTitle(text: controller.sportClass.value?.name ?? ''),
                    const SizedBox(
                      height: 14,
                    ),
                    FilterLocation(
                      totalLocation:
                          controller.locationController.locationSelected.length,
                      onTap: () {
                        Get.dialog(PopUpLocation());
                      },
                    ),
                    const SizedBox(height: 14.0),
                    TextMonth(
                      text: controller.month.value,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 35,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final DateFormat formatter = DateFormat.E();
                            final date = controller.dates[index];
                            return ItemDate(
                              date: '${formatter.format(date)}, ${date.day}',
                              isSelected:
                                  controller.currentIndex.value == index,
                              onTap: () {
                                controller.updateIndex(index);
                                controller.updateMonth(
                                    DateFormat('MMMM yyyy').format(date));
                                controller.getSchedules();
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemCount: controller.dates.length),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                  ],
                ),
              ),
              ClassScheduleSection(
                isLoading: controller.isLoading.isTrue,
                isEmpty: controller.schedules.isEmpty,
                schedules: controller.schedules,
                isLoadingCredit: controller.isLoadingCredit.isTrue,
              )
            ],
          ),
        );
      }),
    );
  }
}
