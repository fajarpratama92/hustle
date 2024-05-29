import 'package:flutter/material.dart';

import '../colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final bool? isObscure;
  final bool? isPassword;
  final bool? isRequired;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final bool? isDisableError;
  final AutovalidateMode? autoValidateMode;

  const CustomTextFormField(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.isObscure,
      this.isPassword,
      this.isRequired,
      this.controller,
      this.validator,
      this.onChanged,
      this.isDisableError,
      this.autoValidateMode});

  @override
  CustomTextFormFieldState createState() {
    return CustomTextFormFieldState();
  }
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
              text: widget.labelText,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w700)),
          TextSpan(
              text: widget.isRequired ?? false ? ' *' : '',
              style: TextStyle(
                  color: red,
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w700))
        ])),
        TextFormField(
          autovalidateMode: widget.autoValidateMode,
          onChanged: widget.onChanged,
          cursorColor: primaryDarkColor,
          controller: widget.controller,
          obscureText: widget.isObscure ?? false ? passwordVisibility : false,
          validator: widget.validator,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'D-DIN Exp',
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
              ),

              errorStyle: TextStyle(
                  color: widget.isDisableError ?? false ? primaryColor : red,
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w400,
                  height: widget.isDisableError ?? false ? 0 : null),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: gray,
                fontSize: 14,
                fontFamily: 'D-DIN Exp',
                fontWeight: FontWeight.w400,
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
              ),
              suffixIcon: widget.isPassword ?? false
                  ? IconButton(
                      icon: Icon(
                        passwordVisibility
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisibility = !passwordVisibility;
                        });
                      },
                    )
                  : null),
        )
      ],
    );
  }
}
