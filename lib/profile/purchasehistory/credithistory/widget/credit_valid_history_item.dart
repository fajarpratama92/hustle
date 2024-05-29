import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/credit_valid_history.dart';

import '../../../../utils/colors.dart';
import '../../../profile_controller.dart';

class CreditValidHistoryItem extends StatelessWidget {
  CreditValidHistoryItem({
    super.key,
    required this.onTap,
    this.creditValidHistory,
    required this.expiredDate
  });

  final VoidCallback onTap;
  final Datum? creditValidHistory;
  final DateTime? expiredDate;

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var daysRemain = expiredDate!.difference(DateTime.now()).inDays;
    if (daysRemain == 0) {
      daysRemain = 1;
    }
    return Container(
      transform: Matrix4.translationValues(0.0, -10.0, 0.0),
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 1, top: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 1, color: disableColor),
            top: BorderSide(width: 1, color: disableColor),
            right: BorderSide(width: 1, color: disableColor),
            bottom: BorderSide(width: 1, color: disableColor),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            margin:
                const EdgeInsets.only(left: 14, right: 14, bottom: 10, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 45,
                  alignment: Alignment.center,
                  child: Text(
                    "${creditValidHistory?.name}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'D-DIN Exp',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    "${creditValidHistory?.transactionDate?.day}-${creditValidHistory?.transactionDate?.month}-${creditValidHistory?.transactionDate?.year}",
                    style: TextStyle(
                      color: gray,
                      fontSize: 14,
                      fontFamily: 'D-DIN Exp',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
