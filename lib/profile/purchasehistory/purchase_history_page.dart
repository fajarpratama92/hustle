import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/credithistory/credit_history_tab.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/packagehistory/package_history_tab.dart';
import 'package:hustle_house_flutter/profile/purchasehistory/voucherhistory/voucher_history_tab.dart';

import '../../utils/colors.dart';

class PurchaseHistoryPage extends StatelessWidget {
  final int? index;

  const PurchaseHistoryPage({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Purchase History',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'D-DIN Exp',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_outlined,
            size: 28,
          ),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [_tabBar(context)],
      ),
    );
  }

  Widget _tabBar(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: DefaultTabController(
          initialIndex: index ?? 0,
          length: 3,
          child: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: TabBar(
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.black,
                        padding: EdgeInsets.zero,
                        indicatorPadding: const EdgeInsets.all(0),
                        labelPadding: EdgeInsets.zero,
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'D-DIN Exp',
                          fontWeight: FontWeight.w700,
                        ),
                        labelColor: Colors.black,
                        unselectedLabelStyle: TextStyle(
                          color: gray,
                          fontSize: 14,
                          fontFamily: 'D-DIN Exp',
                          fontWeight: FontWeight.w700,
                        ),
                        unselectedLabelColor: gray2,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: const [
                          Tab(
                            text: "Credits",
                          ),
                          Tab(
                            text: "Vouchers",
                          ),
                          Tab(
                            text: "Package",
                          ),
                        ]),
                  ),
                  Expanded(
                      child: TabBarView(children: [
                        CreditHistoryTab(),
                        VoucherHistoryTab(),
                        PackageHistoryTab(),
                      ]))
                ],
              )),
        ),
      ),
    );
  }
}
