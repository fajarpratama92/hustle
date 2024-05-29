import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/bookingclass/widget/appbar.dart';
import 'package:hustle_house_flutter/pages/termconditions/term_condition_controller.dart';

import '../../../../utils/colors.dart';

class TermsConditionsPage extends StatelessWidget {
  TermsConditionsPage({super.key});

  final termConditiondController = Get.put(TermConditionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarBookingClass(
        title: 'Terms & Conditions',
        onBackTap: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<TermConditionController>(builder: (_) {
        return SafeArea(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                height: 10,
                indent: 0,
                color: gray1, // Warna abu-abu
                thickness: 10, // Ketebalan pemisah (1 piksel)
              ),
              termConditiondController.termConditionData.isNotEmpty
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            //'Lorem Ipsum',
                            termConditiondController
                                .termConditionData[0].title1,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'D-DIN Exp',
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            // 'Lorem ipsum dolor sit amet consectetur. Nunc sit tempor id sed ultrices quis. Integer amet condimentum et ultrices. Praesent vitae dui sed eget curabitur consectetur. Interdum amet diam eget facilisi. Blandit nulla proin mattis sit nisi vitae vestibulum cras placerat. Arcu lacus nulla eget faucibus id pellentesque gravida non. Pulvinar ac in viverra suspendisse nunc tellus est morbi. Ligula ultrices vitae consectetur tristique pellentesque arcu. Ac ultrices sapien dictumst et dui auctor.',
                            termConditiondController
                                .termConditionData[0].description1,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'D-DIN Exp',
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            //'Lorem Ipsum',
                            termConditiondController
                                .termConditionData[0].title2,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'D-DIN Exp',
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            // 'Lorem ipsum dolor sit amet consectetur. Nunc sit tempor id sed ultrices quis. Integer amet condimentum et ultrices. Praesent vitae dui sed eget curabitur consectetur. Interdum amet diam eget facilisi. Blandit nulla proin mattis sit nisi vitae vestibulum cras placerat. Arcu lacus nulla eget faucibus id pellentesque gravida non. Pulvinar ac in viverra suspendisse nunc tellus est morbi. Ligula ultrices vitae consectetur tristique pellentesque arcu. Ac ultrices sapien dictumst et dui auctor.\n\nLorem ipsum dolor sit amet consectetur. Nunc sit tempor id sed ultrices quis. Integer amet condimentum et ultrices. Praesent vitae dui sed eget curabitur consectetur. Interdum amet diam eget facilisi. Blandit nulla proin mattis sit nisi vitae vestibulum cras placerat. Arcu lacus nulla eget faucibus id pellentesque gravida non. Pulvinar ac in viverra suspendisse nunc tellus est morbi. Ligula ultrices vitae consectetur tristique pellentesque arcu. Ac ultrices sapien dictumst et dui auctor.',
                            termConditiondController
                                .termConditionData[0].description2,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'D-DIN Exp',
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height - 98,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      )),
            ],
          ),
        );
      }),
    );
  }
}
