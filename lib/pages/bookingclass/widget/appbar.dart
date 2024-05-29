import 'package:flutter/material.dart';

class CustomAppBarBookingClass extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Function()? onBackTap;

  CustomAppBarBookingClass({super.key, required this.title, this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'D-DIN Exp',
          fontWeight: FontWeight.w700,
        ),
      ),
      // leading: onBackTap != null
      //     ? IconButton(
      //         icon: SvgPicture.asset('assets/images/chevron-left-outline.svg'),
      //         onPressed: () {
      //           if (onBackTap != null) {
      //             onBackTap!();
      //           }
      //         },
      //       )
      //     : null,
      leading: IconButton(
        //icon: SvgPicture.asset('assets/images/chevron-left-outline.svg'),
        icon: const Icon(
          Icons.chevron_left_outlined,
          size: 28,
          color: Colors.black,
        ),
        onPressed: () {
          if (onBackTap != null) {
            onBackTap!();
          }
        },
      ),
      centerTitle: true,
    );
  }

  @override
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
