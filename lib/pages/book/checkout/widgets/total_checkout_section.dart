import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

class TotalCheckoutSection extends StatelessWidget {
  const TotalCheckoutSection({super.key, required this.total});

  final String total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Total',
            style: DDinExp.bold.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Text(
            '$total Credit(s)',
            style: DDinExp.bold.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
