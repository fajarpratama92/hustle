import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/widgets/empty/empty_photo.dart';
import '../../../../utils/widgets/loading/loading.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return GetBuilder<HomeController>(builder: (_) {
      if (controller.isLoadingProfile.isTrue &&
          controller.isLoadingSubscribe.isTrue) {
        return Loading(
          width: Get.width / 2,
        );
      }
      final activeSubscribe = controller.activeSubscribe.isNotEmpty
          ? controller.activeSubscribe[0]
          : null;
      return Container(
        margin: const EdgeInsets.only(left: 14, right: 14, bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: CachedNetworkImage(
                  height: 50,
                  width: 50,
                  imageUrl:
                      controller.userProfile.value?.member?.imageUrl ?? '',
                  placeholder: (context, url) => SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      )),
                  errorWidget: (context, url, error) {
                    final firstName =
                        controller.userProfile.value?.firstName?[0] ?? '';
                    final lastName =
                        controller.userProfile.value?.lastName?[0] ?? '';
                    return Center(
                        child: EmptyPhoto(
                      initialName: '$firstName$lastName',
                    ));
                  },
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Hi, ${controller.userProfile.value?.firstName ?? ''}!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Oswald',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            Visibility(
              visible: activeSubscribe != null,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: ShapeDecoration(
                  color: _bgColor(activeSubscribe?.anotherName ?? ''),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                child: Text(
                  activeSubscribe?.anotherName ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'D-DIN Exp',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Color _bgColor(String name) {
    bool isAllAccess = name.toLowerCase().contains('class + recovery') ||
        name.toLowerCase().contains('all access');
    if (isAllAccess) {
      return const Color(0xFFD4AF38);
    }
    return const Color(0xFF4169E1);
  }
}
