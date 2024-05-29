import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../model/upcoming_class.dart';
import '../../../utils/colors.dart';
import '../../../utils/widgets/empty/empty_photo.dart';
import '../../../utils/widgets/loading/loading.dart';
import '../../profile_controller.dart';

class UpcomingClassItem extends StatelessWidget {
  UpcomingClassItem({
    super.key,
    required this.onTap,
    this.upcomingClass,
  });

  final VoidCallback onTap;
  final Active? upcomingClass;

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final sessionTime = upcomingClass?.session?.start;
    final DateFormat formatter = DateFormat.EEEE();
    final DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    final DateFormat hourFormat = DateFormat('HH:mm');
    final firstName =
        upcomingClass?.session?.teacher?.firstName?.toUpperCase()[0] ?? '';
    final lastName =
        upcomingClass?.session?.teacher?.lastName?.toUpperCase()[0] ?? '';
    final isTrainer =
        upcomingClass?.session?.category == "personal trainer";
    final isClass =
        upcomingClass?.session?.category == "class";

    return Container(
      transform: Matrix4.translationValues(0.0, -10.0, 0.0),
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 1, top: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 1, color: disableColor),
            top: BorderSide(width: 1, color: disableColor),
            right: BorderSide(width: 1, color: disableColor),
            bottom: BorderSide(width: 1, color: disableColor),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            margin:
                const EdgeInsets.only(left: 14, right: 14, bottom: 10, top: 10),
            child: Row(
              children: [
                !isTrainer
                    ? CachedNetworkImage(
                        width: 50,
                        height: 50,
                        imageUrl: upcomingClass?.session?.sportsClass
                                ?.sportsClassAsset?.logoUrl ??
                            '',
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const Loading(
                          marginHorizontal: 0,
                        ),
                        errorWidget: (context, url, error) {
                          return Center(
                              child: EmptyPhoto(
                            initialName: '$firstName$lastName',
                            sizeFont: 25,
                          ));
                        },
                      )
                    : ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: CachedNetworkImage(
                          width: 50,
                          height: 50,
                          imageUrl:
                              upcomingClass?.session?.teacher?.imageUrl ?? '',
                          fit: BoxFit.contain,
                          placeholder: (context, url) => const Loading(
                            marginHorizontal: 0,
                          ),
                          errorWidget: (context, url, error) {
                            return Center(
                                child: EmptyPhoto(
                              initialName: '$firstName$lastName',
                              sizeFont: 25,
                            ));
                          },
                        ),
                      ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: upcomingClass?.session?.sportsClass?.name ??
                                '${upcomingClass?.session?.teacher?.firstName} ${upcomingClass?.session?.teacher?.lastName}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Oswald',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: " ${hourFormat.format(sessionTime!)}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Oswald',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${formatter.format(sessionTime)}, ${dateFormat.format(sessionTime)}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'D-DIN Exp',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (isClass)
                      Text.rich(
                        TextSpan(
                          children: [
                            if (upcomingClass?.session?.sportsClass?.duration !=
                                null)
                              TextSpan(
                                text:
                                    "${upcomingClass?.session?.sportsClass?.duration} Min \u2022 ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'D-DIN Exp',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            TextSpan(
                              text:
                                  "${upcomingClass?.session?.teacher?.firstName ?? ''} ${upcomingClass?.session?.teacher?.lastName == "Specified" ? "" : upcomingClass?.session?.teacher?.lastName ?? ''}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'D-DIN Exp',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Text(
                      "${upcomingClass?.session?.location?.locationName}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'D-DIN Exp',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                  Container(
                    transform: Matrix4.translationValues(0.0, 22.0, 0.0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          left: BorderSide(width: 1, color: disableColor),
                          top: BorderSide(width: 1, color: disableColor),
                          right: BorderSide(width: 1, color: disableColor),
                          bottom: BorderSide(width: 1, color: disableColor),
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                                child: SvgPicture.asset(
                              'assets/images/ic_award.svg',
                              height: 14,
                              width: 14,
                            )),
                            TextSpan(
                              text:
                                  "  +${isTrainer ? upcomingClass?.session?.teacher?.rewardPoints : upcomingClass?.session?.sportsClass?.rewardPoints }",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'D-DIN Exp',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Divider(color: disableColor, thickness: 1),
          Container(
            alignment: Alignment.center,
            height: 30,
            margin:
                const EdgeInsets.only(left: 14, right: 14, bottom: 7, top: 1),
            child: InkWell(
              onTap: onTap,
              child: const Text(
                'View Details',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
