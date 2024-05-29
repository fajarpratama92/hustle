import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/bookingclass/widget/appbar.dart';
import 'package:hustle_house_flutter/pages/refcode/widget/item_list_referral.dart';

import '../../profile/profile_controller.dart';
import '../../utils/colors.dart';

class ReferralCodePage extends StatelessWidget {
  ReferralCodePage({super.key});

  final ProfileController controller = Get.put(ProfileController());

  //final List<String> username = ['']
  @override
  Widget build(BuildContext context) {
    final String refCode = controller.referralCode.value?.data ?? '';
    return Scaffold(
      appBar: CustomAppBarBookingClass(
        title: 'Referral Code',
        onBackTap: () => Get.back(),
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<ProfileController>(builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 41, bottom: 20),
                  width: double.infinity,
                  color: bgReferralColor,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/ilus.svg',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Refer now & earn credits!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontFamily: 'Oswald',
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: Offset(3, 10)),
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Referral Code:',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'D-DIN Exp',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    refCode,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'D-DIN Exp',
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              //Spacer(),
                              InkWell(
                                onTap: () async {
                                  await Clipboard.setData(
                                          ClipboardData(text: refCode))
                                      .then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Copied to clipboard")));
                                  });
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 80,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.black, width: 1.0)),
                                    child: const Text(
                                      'Copy',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'D-DIN Exp',
                                          fontWeight: FontWeight.w700),
                                    )),
                              )
                            ],
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'How Does it work?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'D-DIN Exp',
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset("assets/images/ic_ref_mail.svg",
                              height: 40, width: 40),
                          const SizedBox(
                            width: 14,
                          ),
                          const Text(
                            'Invite your friend to register on Hustle',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'D-DIN Exp',
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/images/ic_ref_reg.svg",
                            height: 40,
                            width: 40,
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'D-DIN Exp',
                                      fontWeight: FontWeight.w400),
                                  children: [
                                    TextSpan(
                                        text:
                                            'When your friend registers on App, both of you will get '),
                                    TextSpan(
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                        text: '20'),
                                    TextSpan(text: ' credits!')
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text('Referral Used by:',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'D-DIN Exp',
                              fontWeight: FontWeight.w700)),
                      const SizedBox(
                        height: 0,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 14, bottom: 20),
                  child: SizedBox(
                    width: Get.width * 2,
                    child: LimitedBox(
                      maxHeight: 150,
                      child: CustomScrollView(
                        scrollDirection: Axis.horizontal,
                        slivers: [
                          SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 195,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final referred =
                                    controller.referralList.value?.data?[index];
                                return ItemListReferral(
                                  referred: referred,
                                );
                              },
                              childCount:
                                  controller.referralList.value?.data?.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
