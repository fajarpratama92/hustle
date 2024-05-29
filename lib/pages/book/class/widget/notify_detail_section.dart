import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/pages/book/class/widget/status_notify.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../../utils/colors.dart';

class NotifyDetailSection extends StatelessWidget {
  const NotifyDetailSection({super.key, required this.isVisible});

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Get notified when a spot becomes available',
                    style: DDinExp.regular.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                const StatusNotify()
              ],
            ),
          ),
          Divider(
            color: gray1,
            thickness: 1,
            height: 20,
          ),
        ],
      ),
    );
  }
}
