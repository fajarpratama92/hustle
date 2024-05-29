import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/class/detail/argument_class_detail.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/arg_trainer_detail.dart';
import 'package:hustle_house_flutter/utils/extension/string.dart';

import '../../../pages/book/class/detail/class_detail_page.dart';
import '../../../pages/book/class/status_book.dart';
import '../../../pages/book/recovery/detail/arg_recovery_detail.dart';
import '../../../pages/book/recovery/detail/recovery_detail_page.dart';
import '../../../pages/book/trainer/detail/trainer_detail.dart';
import '../../../utils/colors.dart';
import '../../profile_controller.dart';
import '../widget/class_history_item.dart';

class CancelledClassTab extends StatelessWidget {
  CancelledClassTab({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final isClass =
        profileController.bookingHistoryCancelled.value?.data!.isNotEmpty;
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (0.95 * scrollController.position.maxScrollExtent) &&
          profileController.isLoadMoreHistoryCancelled.isTrue) {
        profileController.loadNextPageHistoryCancelled();
      }
    });

    return GetBuilder<ProfileController>(builder: (context) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          controller: scrollController,
          child: isClass ?? false
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ListView.builder(
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: profileController
                            .bookingHistoryCancelled.value?.data!.length,
                        itemBuilder: (context, index) {
                          final sessionId = profileController
                              .bookingHistoryCancelled
                              .value
                              ?.data![index]
                              .session
                              ?.id;
                          final memberId = profileController
                              .bookingHistoryCancelled
                              .value
                              ?.data![index]
                              .memberId;
                          final cancelledClass = profileController
                              .bookingHistoryCancelled.value?.data![index];
                          return ClassHistoryItem(
                            cancelledClass: cancelledClass,
                            isCompleted: false,
                            onTap: () {
                              switch (cancelledClass?.session?.category) {
                                case 'class':
                                  Get.to(() => ClassDetailPage(), arguments: {
                                    ArgumentClassDetail.statusBook:
                                        StatusBook.cancelled,
                                    ArgumentClassDetail.scheduleId: sessionId,
                                    ArgumentClassDetail.memberSessionId:
                                        memberId,
                                    ArgumentClassDetail.sportsClassId:
                                        cancelledClass?.session?.sportsClassId
                                  });
                                  break;
                                case 'recovery':
                                  Get.to(
                                      () => RecoveryDetailPage(
                                            title: 'Recovery',
                                          ),
                                      arguments: {
                                        ArgRecoveryDetail.sessionId: sessionId,
                                        ArgRecoveryDetail.sportClassId:
                                            cancelledClass
                                                ?.session?.sportsClassId,
                                        ArgRecoveryDetail.isCancelled: true
                                      });
                                  break;
                                case 'wellness':
                                  Get.to(
                                      () => RecoveryDetailPage(
                                            title: 'Wellness',
                                          ),
                                      arguments: {
                                        ArgRecoveryDetail.sessionId: sessionId,
                                        ArgRecoveryDetail.sportClassId:
                                            cancelledClass
                                                ?.session?.sportsClassId,
                                        ArgRecoveryDetail.isCancelled: true
                                      });
                                  break;
                                case 'personal trainer':
                                  Get.to(() => TrainerDetail(), arguments: {
                                    ArgTrainerDetail.teacherId:
                                        cancelledClass?.session?.teacherId,
                                    ArgTrainerDetail.isCancelled: true,
                                    ArgTrainerDetail.date: cancelledClass
                                        ?.session?.start
                                        .toString()
                                        .getDateSchedule()
                                  });
                                  break;
                                default:
                                  debugPrint('Invalid category');
                                // Handle other cases here
                              }
                            },
                          );
                        },
                      ),
                    ),
                    if (profileController.isLoadingHistoryCancelled.value ==
                        true)
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                )
              : Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: Get.height / 3.5),
                  width: Get.width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/ic_no_completed_class.svg",
                          height: 119,
                          width: 161.92,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          'There is no cancelled class.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: gray2,
                            fontSize: 14,
                            fontFamily: 'D-DIN Exp',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }
}
