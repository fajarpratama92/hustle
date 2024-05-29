import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/credithistory/widget/credit_expired_history_item.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/credithistory/widget/credit_valid_history_item.dart';
import 'package:hustle_house_flutter/utils/colors.dart';
import 'package:intl/intl.dart';

class CreditHistoryTab extends StatelessWidget {
  CreditHistoryTab({Key? key}) : super(key: key);

  final scrollControllerValid = ScrollController();
  final scrollControllerExpired = ScrollController();
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    scrollControllerValid.addListener(() {
      if (controller.currentPageCreditValid.value <
              controller.lastPageCreditValid.value &&
          scrollControllerValid.position.pixels ==
              scrollControllerValid.position.maxScrollExtent &&
          controller.isLoadMoreCreditValid.isTrue) {
        controller.loadNextCreditValid();
      }
    });
    scrollControllerExpired.addListener(() {
      if (controller.currentPageCreditExpired.value <
              controller.lastPageCreditExpired.value &&
          scrollControllerExpired.position.pixels ==
              scrollControllerExpired.position.maxScrollExtent &&
          controller.isLoadMoreCreditExpired.isTrue) {
        controller.loadNextCreditExpired();
      }
    });
    String? expired = DateFormat('dd-MM-yyyy').format(
        controller.creditValidHistory.value?.activeCreditValid ??
            DateTime(2000));

    return GetBuilder<ProfileController>(builder: (context) {
      var creditValid = controller.creditValidHistory.value?.data?.data!;
      var creditExpired = controller.creditExpiredHistory.value?.data!;
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Visibility(
          visible:
              creditValid?.isNotEmpty ?? creditExpired?.isNotEmpty ?? false,
          replacement: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: Get.height / 3.5),
            width: Get.width,
            child: Center(
              child: SvgPicture.asset(
                "assets/images/ic_no_credit.svg",
                height: 164,
                width: 212,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (creditValid?.isNotEmpty ?? false)
                Container(
                    transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.only(
                        left: 14, right: 14, bottom: 1, top: 20),
                    child: Text("All active credit valid until: $expired",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'D-DIN Exp',
                          fontWeight: FontWeight.w700,
                        ))),
              if (creditValid?.isNotEmpty ?? false)
                Container(
                  height: creditExpired?.isNotEmpty ?? false
                      ? controller.getCreditValidContainerHeight(
                          controller.creditValidHistory.value!.data!)
                      : Get.height / 1.30,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListView.builder(
                            primary: false,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            controller: scrollControllerValid,
                            itemCount: creditValid!.length,
                            itemBuilder: (context, index) {
                              final creditValidHistory =
                                  creditValid.toList()[index];
                              return CreditValidHistoryItem(
                                creditValidHistory: creditValidHistory,
                                expiredDate: creditValidHistory.expired,
                                onTap: () {},
                              );
                            },
                          ),
                        ),
                      ),
                      if (controller.isLoadingCreditValidHistory.value == true)
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  ),
                ),
              if (creditExpired?.isNotEmpty ?? false)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (creditValid?.isNotEmpty ?? false)
                      Divider(thickness: 1, color: disableColor),
                    Container(
                        transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.only(
                            left: 14, right: 14, bottom: 1, top: 20),
                        child: const Text("Credits Expired",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'D-DIN Exp',
                              fontWeight: FontWeight.w700,
                            ))),
                    SizedBox(
                      height: creditValid?.isNotEmpty ?? false
                          ? controller.getCreditExpiredContainerHeight(
                              controller.creditValidHistory.value!.data!)
                          : Get.height / 1.25,
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ListView.builder(
                                primary: false,
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                controller: scrollControllerExpired,
                                itemCount: creditExpired!.length,
                                itemBuilder: (context, index) {
                                  final creditExpiredHistory =
                                      creditExpired.toList()[index];
                                  return CreditExpiredHistoryItem(
                                    creditExpiredHistory: creditExpiredHistory,
                                    onTap: () {},
                                  );
                                },
                              ),
                            ),
                          ),
                          if (controller.isLoadingCreditExpiredHistory.value ==
                              true)
                            const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
    });
  }
}
