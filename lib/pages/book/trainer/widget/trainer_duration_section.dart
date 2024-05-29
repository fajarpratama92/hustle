import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/utils/widgets/detail/location_detail_section.dart';

import '../../../../model/trainer.dart';
import '../../../../utils/widgets/point_reward.dart';

class TrainerDurationSection extends StatelessWidget {
  const TrainerDurationSection({super.key, required this.trainer});

  final Trainer? trainer;

  @override
  Widget build(BuildContext context) {
    bool isFromBookingHistory = Get.previousRoute == '/BookingHistoryPage';
    return Visibility(
      visible: !isFromBookingHistory,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 28,
            ),
            Row(
              children: [
                LocationDetailSection(
                    duration: trainer?.duration ?? 0,
                    location: trainer?.location?.locationName ?? ''),
                const Spacer(),
                PointReward(
                  reward: '+${trainer?.rewardPoint ?? 0}',
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
