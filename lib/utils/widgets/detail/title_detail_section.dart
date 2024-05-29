import 'package:flutter/material.dart';

import '../../../profile/upcomingclass/widget/upcoming_point_reward.dart';
import '../my_credit.dart';
import '../point_reward.dart';

class TitleDetailSection extends StatelessWidget {
  const TitleDetailSection(
      {super.key,
      required this.title,
      required this.isShowCredit,
      required this.price,
      this.isShowPoint,
      required this.rewardPoint});

  final String title;
  final bool isShowCredit;
  final String price;
  final bool? isShowPoint;
  final int rewardPoint;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Oswald',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Spacer(),
        Visibility(
            visible: isShowCredit,
            child: MyCredit(
              credit: price,
              colors: Colors.white,
            )),
        const SizedBox(
          width: 10,
        ),
        Visibility(
          visible: isShowPoint ?? false,
          child: isShowCredit
              ? DisabledPointReward(
                  reward: '+$rewardPoint',
                )
              : PointReward(
                  reward: '+$rewardPoint',
                ),
        )
      ],
    );
  }
}
