import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../colors.dart';

class FloatingButtonIcon extends StatelessWidget {
  const FloatingButtonIcon(
      {super.key,
      required this.text,
      required this.onPressed,
      this.colorButton,
      this.textColor,
      this.credit,
      this.isShowIcon,
      this.borderColor, this.shadowColor});

  final String text;
  final VoidCallback onPressed;
  final Color? colorButton;
  final Color? textColor;
  final String? credit;
  final bool? isShowIcon;
  final Color? borderColor;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: 10, left: 10, right: 10, bottom: Platform.isIOS ? 30 : 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: shadowColor ?? const Color(0x33000000),
              blurRadius: 10,
              offset: const Offset(0, -3),
              spreadRadius: 0,
            )
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(
              const Size(double.infinity, 50),
            ),
            backgroundColor:
                MaterialStateProperty.all(colorButton ?? primaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(27),
              ),
            ),
            side: MaterialStateProperty.all(
              BorderSide(color: borderColor ?? primaryColor, width: 2),
            ),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 10)),
            elevation: MaterialStateProperty.all(0),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      color: textColor ?? Colors.black,
                      fontSize: 14,
                      fontFamily: 'D-DIN Exp',
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(width: isShowIcon ?? false ? 10 : 0),
                Visibility(
                  visible: isShowIcon ?? false,
                  child: SvgPicture.asset(
                    "assets/images/ic_credit.svg",
                  ),
                ),
                SizedBox(width: isShowIcon ?? false ? 10 : 0),
                Visibility(
                  visible: isShowIcon ?? false,
                  child: Text(
                    credit ?? '0',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'D-DIN Exp',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
