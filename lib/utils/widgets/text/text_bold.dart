import 'package:flutter/material.dart';

class TextBold extends StatelessWidget {
  const TextBold({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'D-DIN Exp',
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
