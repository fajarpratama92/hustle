import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/bookingclass/widget/appbar.dart';

import '../../../utils/colors.dart';
import 'membershipcard_controller.dart';

class MembershipCardPage extends StatelessWidget {
  MembershipCardPage({super.key});

  final membershipCardController = Get.put(MembershipCardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarBookingClass(
          title: 'Membership Card',
          onBackTap: () {
            Navigator.of(context).pop();
          }),
      backgroundColor: Colors.white,
      body: GetBuilder<MembershipCardController>(builder: (_) {
        return SafeArea(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(
                height: 10,
                indent: 0,
                color: gray1, // Warna abu-abu
                thickness: 10, // Ketebalan pemisah (1 piksel)
              ),
              const SizedBox(
                height: 0,
              ),
              membershipCardController.termConditionData.isNotEmpty &&
                      (membershipCardController.membershipCodeData.value != '')
                  ? Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 29),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    SvgPicture.asset(
                                      'assets/images/bg_membershipcard.svg',
                                      //alignment: Alignment.centerRight,
                                      //width: MediaQuery.of(context).size.width,
                                      height: 180,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 180,
                                padding: EdgeInsets.all(20),
                                //color: Colors.pink,
                                decoration: BoxDecoration(
                                    //color: Colors.pink,
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.bottomCenter,
                                      colors: [Colors.black, Color(0x3C3C4399)],
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Spacer(),
                                        SvgPicture.asset(
                                          'assets/images/ic_membershipcard.svg',
                                          //alignment: Alignment.centerRight,
                                          //width: MediaQuery.of(context).size.width,
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'VIP Member',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 28,
                                        fontFamily: 'Oswald',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      //'Member Code: ABC1234',
                                      membershipCardController
                                          .membershipCodeData.value,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 14,
                                        fontFamily: 'D-DIN Exp',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 0.5,
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(6),
                                        child: Text(
                                          'Valid Until : ' +
                                              //'Valid Until: 30-12-2023',
                                              membershipCardController
                                                  .expiredDate.value,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'D-DIN Exp',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            membershipCardController
                                .termConditionData[0].title1,
                            //'Lorem Ipsum'
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Oswald',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            //'Lorem ipsum dolor sit amet consectetur. Ultrices vestibulum odio arcu sed malesuada venenatis odio sed nunc. Morbi velit suscipit egestas id at diam. Malesuada turpis morbi nunc morbi. Eu velit nisl nec tempus enim.',
                            membershipCardController
                                .termConditionData[0].description1,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'D-DIN Exp',
                              fontWeight: FontWeight.w400,
                            ),
                          )
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
