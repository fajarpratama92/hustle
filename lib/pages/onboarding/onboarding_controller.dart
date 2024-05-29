import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  final List<String> backgrounds = [
    "assets/images/on_boarding_1.png",
    "assets/images/on_boarding_2.png",
    "assets/images/on_boarding_3.png",
  ];

  RxInt page = 0.obs;

  void onChangePage() {
    if (page.value < 2) {
      page.value++;
      update();
    }
  }
}
