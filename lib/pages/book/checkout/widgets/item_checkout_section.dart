import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/typography/oswald.dart';
import 'package:hustle_house_flutter/utils/widgets/image/image_cover.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/widgets/empty/empty_photo.dart';
import '../../../../utils/widgets/my_credit.dart';

class ItemCheckoutSection extends StatelessWidget {
  const ItemCheckoutSection(
      {super.key,
      required this.isClass,
      required this.imageUrl,
      required this.name,
      required this.hour,
      required this.date,
      required this.trainer,
      required this.location,
      required this.total});

  final bool isClass;
  final String imageUrl;
  final String name;
  final String hour;
  final String date;
  final String trainer;
  final String location;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _image(),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$name • $hour',
                style: Oswald.bold.copyWith(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(date,
                  style: DDinExp.regular
                      .copyWith(color: Colors.black, fontSize: 14)),
              Visibility(
                visible: isClass,
                child: Text(trainer,
                    style: DDinExp.regular
                        .copyWith(color: Colors.black, fontSize: 14)),
              ),
              const SizedBox(height: 5),
              Visibility(
                visible: location.isNotEmpty,
                child: Text(
                  location,
                  style: DDinExp.regular
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ),
            ],
          ),
          const Spacer(),
          const SizedBox(width: 3),
          MyCredit(
            colors: primaryColor,
            credit: total,
          ),
        ],
      ),
    );
  }

  Widget _image() {
    if (isClass) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: ImageCover(
          height: 50,
          width: 50,
          url: imageUrl,
        ),
      );
    }
    final fullName = name.split(' ');
    final firstName = fullName[0][0];
    final lastName = (fullName.length) > 1 ? fullName[1][0] : '';
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: ImageCover(
          height: 50,
          width: 50,
          url: imageUrl,
          errorWidget: Center(
              child: EmptyPhoto(
            initialName: '$firstName$lastName',
          )),
        ));
  }
}
