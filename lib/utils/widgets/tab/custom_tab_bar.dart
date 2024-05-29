import 'package:flutter/material.dart';

import '../../colors.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {super.key,
      required this.length,
      required this.tabs,
      required this.pages,
      this.isScrollable});

  final int length;
  final List<Widget> tabs;
  final List<Widget> pages;
  final bool? isScrollable;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: DefaultTabController(
          initialIndex: 0,
          length: length,
          child: SafeArea(
              child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: TabBar(
                    dividerColor: Colors.transparent,
                    isScrollable: isScrollable ?? false,
                    indicatorColor: Colors.black,
                    padding: EdgeInsets.zero,
                    indicatorPadding:
                        EdgeInsets.all((isScrollable ?? false) ? 0 : -5),
                    labelPadding:
                        (isScrollable ?? false) ? null : EdgeInsets.zero,
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
                    tabs: tabs),
              ),
              Expanded(child: TabBarView(children: pages))
            ],
          )),
        ),
      ),
    );
  }
}
