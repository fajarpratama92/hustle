import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExpandedTextWidget extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color fontColor;
  final bool showChevronIcon;
  final List<Widget> children;

  const ExpandedTextWidget({
    Key? key,
    required this.text,
    this.fontSize = 14,
    this.fontColor = const Color(0xFF6D6D6D),
    this.showChevronIcon = true,
    required this.children,
  }) : super(key: key);

  @override
  _ExpandedTextWidgetState createState() => _ExpandedTextWidgetState();
}

class _ExpandedTextWidgetState extends State<ExpandedTextWidget> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              flag = !flag;
            });
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: widget.text,
              style: TextStyle(
                color: widget.fontColor,
                fontSize: widget.fontSize,
                fontFamily: 'D-DIN Exp',
                fontWeight: FontWeight.w400,
              ),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Visibility(
                visible: widget.showChevronIcon,
                child: SvgPicture.asset(
                  flag == false
                      ? "assets/images/chevron-up-outline.svg"
                      : "assets/images/chevron-down-outline.svg",
                  height: 24,
                  width: 24,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ])),
        ),
        if (flag == false)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.children,
          ),
      ],
    );
  }
}
