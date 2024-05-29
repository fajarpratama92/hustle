import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/bookingclass/packages/detail/package_detail_controller.dart';


class PolicyPackageSection extends StatelessWidget {
  const PolicyPackageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PackageDetailController>();
    final package = controller.package.value;
    return GetBuilder<PackageDetailController>(
        builder: (_) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Package policy',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'D-DIN Exp',
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Text(
                  package?.packagePolicy ?? '',
                  maxLines: controller.isReadMore.isTrue ? null : 6,
                  overflow:
                  controller.isReadMore.isTrue ? null : TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'D-DIN Exp',
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 14),
                Visibility(
                  visible: (package?.packagePolicy?.length ?? 0) > 300,
                  child: Container(
                    margin: const EdgeInsets.only(top: 14, bottom: 20),
                    child: InkWell(
                      onTap: () {
                        controller.updateReadMore();
                      },
                      child: Text(
                        controller.isReadMore.isTrue
                            ? 'Read less'
                            : 'Read more',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'D-DIN Exp',
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}
