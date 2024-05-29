import 'package:flutter/material.dart';

class EmptyPhoto extends StatelessWidget {
  const EmptyPhoto(
      {super.key, required this.initialName, this.sizePhoto, this.sizeFont});

  final String initialName;
  final double? sizePhoto;
  final double? sizeFont;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizePhoto ?? 50,
      height: sizePhoto ?? 50,
      decoration: const ShapeDecoration(
        color: Colors.black,
        shape: OvalBorder(),
      ),
      child: Center(
        child: Text(
          initialName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: sizeFont ?? 16,
            fontFamily: 'Oswald',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
