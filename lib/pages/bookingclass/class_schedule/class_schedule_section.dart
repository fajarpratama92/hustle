import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/widgets/empty/empty_class.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/list_loading.dart';

import '../../../model/schedule.dart';
import '../../../utils/colors.dart';
import '../../book/class/detail/argument_class_detail.dart';
import '../../book/class/detail/class_detail_page.dart';
import '../../book/class/status_book.dart';
import '../../book/class/widget/item_book_class.dart';

class ClassScheduleSection extends StatelessWidget {
  const ClassScheduleSection(
      {super.key,
      required this.isLoading,
      required this.isEmpty,
      required this.schedules,
      required this.isLoadingCredit});

  final bool isLoading;
  final bool isEmpty;
  final List<Schedule> schedules;
  final bool isLoadingCredit;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const ListLoading();
    }

    if (schedules.isEmpty) {
      return const EmptyClass();
    }
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var schedule = schedules[index];
          String? notify = schedule.notifyMe != null ? 'waiting' : null;
          StatusBook statusBook =
              getStatusBook(notify ?? schedule.status ?? '');
          return InkWell(
            onTap: () {
              Get.to(() => ClassDetailPage(), arguments: {
                ArgumentClassDetail.statusBook: statusBook,
                ArgumentClassDetail.scheduleId: schedule.id,
                ArgumentClassDetail.memberSessionId: schedule.memberSession?.id,
                ArgumentClassDetail.sportsClassId: schedule.sportsClassId
              });
            },
            child: ItemBookClass(
              color: statusBook == StatusBook.book ||
                      statusBook == StatusBook.booked
                  ? Colors.black
                  : gray,
              statusBook: statusBook,
              schedule: schedule,
              isLoadingCredit: isLoadingCredit,
            ),
          );
        },
        itemCount: schedules.length);
  }
}
