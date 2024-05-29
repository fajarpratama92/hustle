import 'package:flutter/material.dart';

import '../colors.dart';

class DateBirthTextField extends StatelessWidget {
  final void Function() onPressed;
  final String? day;
  final String? month;
  final String? year;
  final bool? isError;

  const DateBirthTextField(
      {super.key,
      required this.onPressed,
      this.day,
      this.month,
      this.year,
      this.isError});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: [
          const TextSpan(
              text: 'Date of Birth',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w700)),
          TextSpan(
              text: ' *',
              style: TextStyle(
                  color: red,
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w500))
        ])),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: onPressed,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day == null || (day?.isEmpty ?? false) ? 'DD' : day ?? '',
                      style: TextStyle(
                        color: day == null || (day?.isEmpty ?? false)
                            ? gray
                            : Colors.black,
                        fontSize: 14,
                        fontFamily: 'D-DIN Exp',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.8),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      month == null || (month?.isEmpty ?? false)
                          ? 'MM'
                          : month ?? '',
                      style: TextStyle(
                        color: month == null || (month?.isEmpty ?? false)
                            ? gray
                            : Colors.black,
                        fontSize: 14,
                        fontFamily: 'D-DIN Exp',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.8),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      year == null || (year?.isEmpty ?? false)
                          ? 'YY'
                          : year ?? '',
                      style: TextStyle(
                        color: year == null || (year?.isEmpty ?? false)
                            ? gray
                            : Colors.black,
                        fontSize: 14,
                        fontFamily: 'D-DIN Exp',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.8),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
