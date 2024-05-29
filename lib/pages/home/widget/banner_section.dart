import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';

import '../../../utils/colors.dart';
import '../../../utils/widgets/custom_web_view.dart';
import '../../../utils/widgets/loading/loading.dart';
import 'item_banner.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return GetBuilder<HomeController>(builder: (_) {
      if (controller.isLoadingBanner.isTrue) {
        return const Loading(
          height: 200,
        );
      }
      return Stack(
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: controller.banners.length,
              itemBuilder: (BuildContext context, int index) {
                final banner = controller.banners[index];
                return ItemBanner(
                  title: banner.title,
                  description: banner.description,
                  image: banner.imageUrl,
                  onTap: () {
                    controller.initWebView(
                        banner.link ?? 'https://hustlehouse.co.id/');
                    Get.to(() => CustomWebView(
                        title: banner.title ?? '',
                        webViewController: controller.webViewController));
                  },
                );
              },
            ),
          ),
          Positioned(
            right: 19,
            bottom: 14,
            child: DotsIndicator(
              dotsCount: controller.banners.length,
              position: controller.currentPage.value,
              decorator: DotsDecorator(
                color: Colors.white,
                spacing: const EdgeInsets.symmetric(horizontal: 4),
                activeColor: primaryColor,
                size: const Size(8, 8),
                activeSize: const Size(16.0, 8),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
