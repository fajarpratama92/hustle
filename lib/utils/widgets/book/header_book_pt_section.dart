import 'package:flutter/material.dart';

import '../../colors.dart';
import '../my_credit.dart';

class HeaderBookSection extends StatelessWidget {
  const HeaderBookSection({super.key, this.name, this.price});

  final String? name;
  final String? price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: 14, right: 14, top: 20, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name ?? '',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Oswald',
              fontWeight: FontWeight.w500,
            ),
          ),
          MyCredit(
            credit: price,
            colors: primaryColor,
          ),
        ],
      ),
    );
  }

}