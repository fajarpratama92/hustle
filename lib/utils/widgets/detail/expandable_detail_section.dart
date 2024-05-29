import 'package:flutter/material.dart';

import '../../colors.dart';
import '../expandable_text.dart';

class ExpandableDetailSection extends StatelessWidget {
  const ExpandableDetailSection(
      {super.key,
      required this.title,
      required this.description,
      this.onTap,
      this.isExpand,
      required this.isVisible});

  final String title;
  final String description;
  final VoidCallback? onTap;
  final bool? isExpand;
  final bool? isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible ?? true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ExpandableText(
              title: title,
              description: description,
              isExpand: isExpand,
              onTap: onTap,
            ),
          ),
          Divider(
            color: gray1,
            thickness: 1,
            height: 20,
          ),
        ],
      ),
    );
  }
}
