import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/purchase/credit/credit_controller.dart';

import '../../utils/colors.dart';
import 'item_quick_amount.dart';

class ItemCounter extends StatelessWidget {
  final controller = Get.find<CreditController>();

  ItemCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          transform: Matrix4.translationValues(0.0, -10.0, 0.0),
          padding: const EdgeInsets.all(1),
          margin:
              const EdgeInsets.only(left: 14, right: 14, bottom: 10, top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(color: disableColor),
              top: BorderSide(width: 1, color: disableColor),
              right: BorderSide(color: disableColor),
              bottom: BorderSide(width: 1, color: disableColor),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    left: BorderSide(color: disableColor),
                    top: BorderSide(width: 1, color: disableColor),
                    right: BorderSide(color: disableColor),
                    bottom: BorderSide(width: 1, color: disableColor),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    controller.decrement();
                  },
                ),
              ),
              Container(
                width: Get.width / 2,
                height: 40,
                margin: const EdgeInsets.only(
                    bottom: 20, top: 20, left: 20, right: 20),
                child: Center(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller.counterController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      try {
                        controller.updateCurrentValue(int.parse(value));
                      } catch (e) {
                        controller.updateCurrentValue(0);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Amount",
                      hintStyle: TextStyle(
                        color: gray2,
                        fontSize: 14,
                        fontFamily: 'D-DIN Exp',
                        fontWeight: FontWeight.w400,
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 34,
                      fontFamily: 'D-DIN Exp',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  border: Border(
                    left: BorderSide(color: disableColor),
                    top: BorderSide(width: 1, color: disableColor),
                    right: BorderSide(color: disableColor),
                    bottom: BorderSide(width: 1, color: disableColor),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    controller.increment();
                  },
                ),
              )
            ],
          ),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -10.0, 0.0),
          padding: const EdgeInsets.all(5),
          margin:
              const EdgeInsets.only(left: 14, right: 14, bottom: 10, top: 10),
          child: GridView.builder(
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              String quickAmount = controller.quickAmounts[index];
              return ItemAutoFill(
                amount: "$quickAmount Credits",
                isSelected: controller.creditSelected.value == index,
                onTap: () {
                  controller.updateCreditSelected(index);
                  controller.currentValue.value = int.parse(
                      controller.quickAmounts[controller.creditSelected.value]);
                  controller.counterController.text =
                      controller.currentValue.value.toString();
                },
              );
            },
          ),
        )
      ],
    );
  }
}
