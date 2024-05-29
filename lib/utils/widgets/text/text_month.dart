import 'package:flutter/material.dart';

class TextMonth extends StatelessWidget {
  const TextMonth({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'Oswald',
        fontWeight: FontWeight.w500,
      ),
    );
  }

}