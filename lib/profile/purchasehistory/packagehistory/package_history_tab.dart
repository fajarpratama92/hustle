import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/bookingclass/packages/detail/package_detail_page.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/packagehistory/widget/package_history_item.dart';

class PackageHistoryTab extends StatelessWidget {
  PackageHistoryTab({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (0.95 * scrollController.position.maxScrollExtent) &&
          controller.isLoadMorePackage.isTrue) {
        controller.loadNextPackage();
      }
    });

    return GetBuilder<ProfileController>(builder: (context) {
      return Obx(
        () => SingleChildScrollView(
          child: Container(
            transform: Matrix4.translationValues(0.0, 10.0, 0.0),
            padding: const EdgeInsets.all(0),
            child: Visibility(
              visible:
                  controller.packageHistory.value?.data!.isNotEmpty ?? false,
              replacement: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: Get.height / 3.5),
                width: Get.width,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/images/ic_no_package.svg",
                    height: 164,
                    width: 212,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListView.builder(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.packageHistory.value?.data?.length,
                      itemBuilder: (context, index) {
                        final packageHistory = controller
                            .packageHistory.value?.data
                            ?.toList()[index];
                        return PackageHistoryItem(
                          packageHistory: packageHistory,
                          onTap: () {
                            Get.to(
                              () => PackageDetailPage(),
                                arguments: [packageHistory?.packageId]);
                          },
                        );
                      },
                    ),
                  ),
                  if (controller.isLoadingPackageHistory.value == true)
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
