import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? isNoLeading;
  final bool? isNoDivider;
  final VoidCallback? onPressed;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.isNoLeading,
      this.isNoDivider,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'D-DIN Exp',
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      toolbarHeight: kToolbarHeight,
      elevation: 0,
      leading: !(isNoLeading ?? false)
          ? IconButton(
              icon: const Icon(
                Icons.chevron_left_outlined,
                size: 28,
              ),
              color: Colors.black,
              onPressed: onPressed ??
                  () {
                    Get.back();
                  },
            )
          : null,
      bottom: !(isNoDivider ?? false)
          ? PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight / 4),
              child: Divider(thickness: 10, color: gray1),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      !(isNoDivider ?? false) ? kToolbarHeight * 1.25 : kToolbarHeight);
}
