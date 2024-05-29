import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hustle_house_flutter/model/credit_expired_history.dart';
import 'package:intl/intl.dart';

import '../../../../utils/colors.dart';

class CreditExpiredHistoryItem extends StatelessWidget {
  const CreditExpiredHistoryItem({
    super.key,
    required this.onTap,
    this.creditExpiredHistory,
  });

  final VoidCallback onTap;
  final Datum? creditExpiredHistory;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${creditExpiredHistory?.name}",
                      style: TextStyle(
                        color: gray,
                        fontSize: 20,
                        fontFamily: 'D-DIN Exp',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                              child: SvgPicture.asset(
                            'assets/images/ic_clock_outline.svg',
                            height: 14,
                            width: 14,
                            color: gray,
                          )),
                          const WidgetSpan(
                              child: SizedBox(
                            width: 5,
                          )),
                          TextSpan(
                            text:
                                "Expired date: ${dateFormat.format(creditExpiredHistory!.expired!)}",
                            style: TextStyle(
                              color: gray,
                              fontSize: 14,
                              fontFamily: 'D-DIN Exp',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    dateFormat.format(creditExpiredHistory!.transactionDate!),
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
