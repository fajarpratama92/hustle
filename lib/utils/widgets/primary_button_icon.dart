import 'package:flutter/material.dart';

import '../colors.dart';

class PrimaryButtonIcon extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final double? sizeWidth;
  final double? sizeHeight;
  final double? borderRadiusSize;
  final Color? borderSideColor;
  final Color? colorButton;
  final Color? textColor;
  final double? fontSize;
  final double? elevation;
  final double? letterSpacing;
  final IconData? icon;

  const PrimaryButtonIcon(
      {Key? key,
      this.text,
      this.onPressed,
      this.sizeWidth,
      this.sizeHeight,
      this.borderRadiusSize,
      this.borderSideColor,
      this.colorButton,
      this.textColor,
      this.fontSize,
      this.elevation,
      this.letterSpacing,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
          Size(sizeWidth ?? double.infinity, sizeHeight ?? 50),
        ),
        backgroundColor: MaterialStateProperty.all(colorButton ?? primaryColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusSize ?? 27),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(color: borderSideColor ?? primaryColor),
        ),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 10)),
        elevation: MaterialStateProperty.all(elevation ?? 2),
      ),
      child: Center(
        child: Row(
          children: [
            const Spacer(),
            Text(
              text ?? "",
              style: TextStyle(
                  color: textColor ?? Colors.black,
                  fontSize: fontSize ?? 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            Icon(
              icon,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
