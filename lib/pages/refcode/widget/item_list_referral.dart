import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/referral_list.dart';

import '../../../profile/profile_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/widgets/empty/empty_photo.dart';

class ItemListReferral extends StatelessWidget {
  //final String title;

  ItemListReferral({super.key, required this.referred});

  final Datum? referred;

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFE6E6E6)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: CachedNetworkImage(
                      height: 30,
                      width: 30,
                      imageUrl: referred?.member?.imageUrl ?? '',
                      placeholder: (context, url) => SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          )),
                      errorWidget: (context, url, error) {
                        final firstName = referred?.member?.user?.firstName
                                ?.toUpperCase()[0] ??
                            '';
                        final lastName = referred?.member?.user?.lastName
                                ?.toUpperCase()[0] ??
                            '';
                        return Center(
                            child: EmptyPhoto(
                          initialName: '$firstName$lastName',
                        ));
                      },
                      fit: BoxFit.cover,
                    )),
                const SizedBox(width: 10),
                SizedBox(
                  child: Text(
                    '${referred?.member?.user?.firstName} ${referred?.member?.user?.lastName}',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'D-DIN Exp',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${referred?.createdAt?.day}-${referred?.createdAt?.month}-${referred?.createdAt?.year}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF6D6D6D),
              fontSize: 12,
              fontFamily: 'D-DIN Exp',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
