import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class ItemSchedule extends StatelessWidget {
  const ItemSchedule(
      {super.key, required this.time, this.isSelected, this.onTap});

  final String time;
  final bool? isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          color: isSelected ?? false ? primaryColor : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: disableColor),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Center(
          child: Text(
            time,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'D-DIN Exp',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
