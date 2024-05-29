import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExpandableText extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onTap;
  final bool? isExpand;

  const ExpandableText(
      {super.key,
      required this.title,
      this.onTap,
      this.isExpand,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'D-DIN Exp',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SvgPicture.asset(
                  isExpand ?? false
                      ? "assets/images/ic_up.svg"
                      : "assets/images/ic_down.svg",
                )
              ],
            ),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              firstChild: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'D-DIN Exp',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              secondChild: Container(),
              crossFadeState: isExpand ?? false
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            )
          ],
        ),
      ),
    );
  }
}
