import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocationDetailSection extends StatelessWidget {
  const LocationDetailSection(
      {super.key, required this.duration, required this.location});

  final int duration;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/images/ic_clock.svg",
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '$duration min',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'D-DIN Exp',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          width: 13,
        ),
        SvgPicture.asset(
          "assets/images/ic_location.svg",
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          location,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'D-DIN Exp',
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
