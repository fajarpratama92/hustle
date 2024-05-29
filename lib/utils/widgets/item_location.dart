import 'package:flutter/material.dart';

class ItemLocation extends StatelessWidget {
  const ItemLocation({super.key, this.name, this.isCheck, this.onTap});

  final String? name;
  final bool? isCheck;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'D-DIN Exp',
                fontWeight: FontWeight.w400,
              ),
            ),
            Visibility(
              visible: isCheck ?? false,
              child: const Icon(
                Icons.check,
                color: Colors.black,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
