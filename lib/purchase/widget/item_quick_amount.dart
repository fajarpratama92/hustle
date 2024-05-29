import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class ItemAutoFill extends StatelessWidget {
  const ItemAutoFill(
      {super.key, required this.amount, this.onTap, this.isSelected});

  final String amount;
  final VoidCallback? onTap;
  final bool? isSelected;

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
            amount,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'D-DIN Exp',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
