import 'package:flutter/material.dart';

class TextItalic extends StatelessWidget {
  const TextItalic({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontStyle: FontStyle.italic,
        fontFamily: 'D-DIN Exp',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
