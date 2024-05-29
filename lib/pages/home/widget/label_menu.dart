import 'package:flutter/material.dart';

class LabelMenu extends StatelessWidget {
  const LabelMenu({super.key, required this.menu, this.onTap});

  final String menu;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            menu,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'D-DIN Exp',
              fontWeight: FontWeight.w700,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: const Text(
              'See all',
              style: TextStyle(
                color: Color(0xFF6D6D6D),
                fontSize: 14,
                fontFamily: 'D-DIN Exp',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
