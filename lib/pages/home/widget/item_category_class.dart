import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/model/sport_class_type.dart';

import '../../../utils/widgets/loading/loading.dart';

class ItemCategoryClass extends StatelessWidget {
  const ItemCategoryClass({super.key, this.sportsClassType});

  final SportsClassType? sportsClassType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
              height: 20,
              width: 20,
              imageUrl: sportsClassType?.imageUrl ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => const Loading(
                    marginHorizontal: 0,
                  ),
              errorWidget: (context, url, error) => const Center(
                      child: Icon(
                    Icons.error,
                    size: 20,
                  ))),
          const SizedBox(width: 10),
          Text(
            sportsClassType?.name ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'D-DIN Exp',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
