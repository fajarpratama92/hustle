import 'package:flutter/material.dart';

class TextDescription extends StatelessWidget {
  const TextDescription({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'D-DIN Exp',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
