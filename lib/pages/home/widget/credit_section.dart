import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';

import '../../../utils/widgets/loading/loading.dart';
import '../../../utils/widgets/primary_button.dart';
import '../../main/main_controller.dart';

class CreditSection extends StatelessWidget {
  const CreditSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();
    final controller = Get.find<HomeController>();

    return GetBuilder<HomeController>(builder: (_) {
      if (controller.isLoadingProfile.isTrue) {
        return const Loading(
          height: 60,
        );
      }
      return InkWell(
        onTap: () {},
        child: Container(
          transform: Matrix4.translationValues(0.0, -20.0, 0.0),
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 0),
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/ic_credit.svg",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Your Credits:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'D-DIN Exp',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    controller.userProfile.value?.member?.remainingCredit
                            .toString() ??
                        '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'D-DIN Exp',
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              PrimaryButton(
                text: 'Top-Up Credits',
                borderRadiusSize: 10,
                onPressed: () {
                  mainController.updateIndex(2);
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
