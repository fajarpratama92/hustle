import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/model/package_first_timer.dart';

import '../../../utils/extension/int.dart';
import '../../../utils/extension/string.dart';

class ItemCheckoutSection extends StatelessWidget {
  const ItemCheckoutSection({super.key, required this.package});

  final Package? package;

  @override
  Widget build(BuildContext context) {
    var description =
        package?.description?.removeAllHtmlTags().split(',').join() ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                package?.name ?? '',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${package?.price} Credits',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Valid for ${package?.expiry?.parseMonth()} Month',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'D-DIN Exp',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description.replaceFirst(' ', ''),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'D-DIN Exp',
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
