import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../colors.dart';

class EmptyClass extends StatelessWidget {
  const EmptyClass({super.key, this.text, this.image});

  final String? text;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      alignment: Alignment.center,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image ?? "assets/images/ic_no_class.svg",
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            text ?? 'No Class Found',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: gray2,
              fontSize: 14,
              fontFamily: 'D-DIN Exp',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
