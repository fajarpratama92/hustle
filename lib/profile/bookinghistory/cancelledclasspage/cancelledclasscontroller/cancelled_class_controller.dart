import 'package:get/get.dart';

import '../../../../model/cancelled_class.dart';

class CancelledClassController extends GetxController {
  List<CancelledClass> cancelledClass = [
    CancelledClass(type: "class", title: 'Kiss My Abs', time: '18.30', image: 'assets/images/ic_kiss_my_abs.svg', schedule: "Tuesday, 2 Oct 2023", duration: "60", trainer: "Sarah", location: "Jakarta Timur", rating: "0", points: "5",),
    CancelledClass(type: "class", title: 'Machine Guns', time: '18.30', image: 'assets/images/ic_machine_guns.svg', schedule: "Tuesday, 2 Oct 2023", duration: "60", trainer: "Sarah", location: "Jakarta Timur", rating: "3", points: "20",),
  ];
}