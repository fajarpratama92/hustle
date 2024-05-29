import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';

import '../../../../utils/colors.dart';
import '../../../notification/notification_page.dart';

class NotificationBar extends StatelessWidget {
  const NotificationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return GetBuilder<HomeController>(builder: (_) {
      return InkWell(
        onTap: () {
          Get.to(() => NotificationPage());
        },
        child: Container(
          width: 44,
          height: 44,
          margin: const EdgeInsets.only(right: 14),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor,
          ),
          child: Stack(
            children: [
              SvgPicture.asset(
                "assets/images/ic_notification.svg",
              ),
              Visibility(
                visible: controller.isNewNotification.isTrue,
                child: Positioned(
                  right: 2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: red, // inner circle color
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
