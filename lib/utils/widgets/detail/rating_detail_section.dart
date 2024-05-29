import 'package:flutter/material.dart';

class RatingDetailSection extends StatelessWidget {
  const RatingDetailSection(
      {super.key,
      required this.isVisible,
      required this.averageRating,
      required this.totalRating});

  final bool isVisible;
  final double averageRating;
  final int totalRating;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Text(
              averageRating.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'D-DIN Exp',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            const Icon(
              Icons.star,
              color: Colors.black,
              size: 14,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              '($totalRating)',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'D-DIN Exp',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
