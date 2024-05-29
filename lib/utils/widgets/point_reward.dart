import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/utils/colors.dart';

class PointReward extends StatelessWidget {
  final String? reward;
  const PointReward({super.key, this.reward});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: ShapeDecoration(
        color: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/ic_award.svg",
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 5),
          Text(
            reward ?? '',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'D-DIN Exp',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

}