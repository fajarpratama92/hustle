import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/order.dart';
import '../../../utils/colors.dart';

class OrderDetailSection extends StatelessWidget {
  const OrderDetailSection({super.key, required this.order});

  final Order? order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/images/ic_order.svg"),
              const SizedBox(
                width: 6,
              ),
              const Text(
                'Order details',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            color: gray1,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Subtotal',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '${order?.subTotal} Credits',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 9,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Discount',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                order?.totalDiscount.toString() ?? '0',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 9,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '${order?.total} Credits',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
