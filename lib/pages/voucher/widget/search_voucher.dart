import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class SearchVoucher extends StatelessWidget {
  const SearchVoucher(
      {super.key,
      required this.onChanged,
      this.controller,
      this.title,
      this.onCancel});

  final Function(String) onChanged;
  final TextEditingController? controller;
  final String? title;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: primaryDarkColor,
      decoration: InputDecoration(
          hintText: 'Enter a ${title ?? "voucher"} code',
          hintStyle: TextStyle(
            color: gray2,
            fontSize: 14,
            fontFamily: 'D-DIN Exp',
            fontWeight: FontWeight.w400,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          suffixIcon: InkWell(
            onTap: onCancel,
            child: const Padding(
              padding: EdgeInsets.all(14.0),
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: disableColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: disableColor),
          ),
          filled: true,
          fillColor: Colors.white),
    );
  }
}
