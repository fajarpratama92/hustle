
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors.dart';

class ProfileButton extends StatelessWidget {
  final String svgAsset;
  final String text;
  final bool hasCountLabel;
  final bool hasNavigationArrow;
  final VoidCallback? onPressed;
  final String numbers;
  final double topMargins;
  final Color color;

  const ProfileButton({
    Key? key,
    required this.svgAsset,
    required this.text,
    this.hasNavigationArrow = true,
    this.hasCountLabel = false,
    this.onPressed, this.numbers = "",
    this.topMargins = 30,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -10.0, 0.0),
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.only(left: 14, right: 14, bottom: 10, top: topMargins),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        margin: const EdgeInsets.only(right:8),
                        padding: const EdgeInsets.all(6),
                        child: SvgPicture.asset(
                          svgAsset,
                          height: 24,
                          width: 24,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'D-DIN Exp',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 6,),
                    ],
                  ),
                  const Spacer(),
                  if (hasCountLabel != false)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor, // inner circle color
                          ),
                          child: Text(
                            numbers,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'D-DIN Exp',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  if (hasNavigationArrow != false)
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.black,
                      size: 28,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
