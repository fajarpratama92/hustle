import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/model/purchase_list.dart';
import 'package:hustle_house_flutter/utils/colors.dart';
import 'package:hustle_house_flutter/utils/extension/int.dart';
import 'package:hustle_house_flutter/utils/extension/string.dart';

class ItemPurchase extends StatelessWidget {
  const ItemPurchase({super.key, this.isExpired, required this.purchaseList});

  final bool? isExpired;
  final PurchaseList purchaseList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: disableColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                purchaseList.title ?? '',
                style: TextStyle(
                  color: _color(color: Colors.black),
                  fontSize: 20,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                purchaseList.requestTime?.formatDate(format: 'dd-MM-yyyy') ?? '',
                style: TextStyle(
                  color: gray,
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            purchaseList.description ?? '',
            style: TextStyle(
              color: gray,
              fontSize: 14,
              fontFamily: 'D-DIN Exp',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                purchaseList.price?.formatIDR() ?? '',
                style: TextStyle(
                  color: _color(color: Colors.black),
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                (isExpired ?? false) ? 'Expired' : 'Not paid',
                style: TextStyle(
                  color: _color(color: red),
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Color? _color({Color? color}) {
    if (isExpired ?? false) {
      return gray;
    }
    return color;
  }
}
