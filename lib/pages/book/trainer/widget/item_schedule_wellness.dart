import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemScheduleWellness extends StatelessWidget {
  const ItemScheduleWellness(
      {super.key, required this.name, this.isSelected, this.onTap});

  final String name;
  final bool? isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'D-DIN Exp',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 10),
          Visibility(
            visible: isSelected ?? false,
            child: SvgPicture.asset(
              "assets/images/ic_checklist.svg",
              width: 20,
              height: 20,
            ),
          )
        ],
      ),
    );
  }
}
