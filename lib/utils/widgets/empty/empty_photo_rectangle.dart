import 'package:flutter/material.dart';

class EmptyPhotoRectangle extends StatelessWidget {
  const EmptyPhotoRectangle({super.key, required this.initialName});

  final String initialName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          initialName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Oswald',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
