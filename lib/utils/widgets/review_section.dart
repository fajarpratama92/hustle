import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/comment.dart';
import 'package:hustle_house_flutter/model/review.dart';

import '../../pages/review/review_page.dart';
import '../colors.dart';
import '../extension/string.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection(
      {super.key, this.review, this.comment, this.id, this.isVisible});

  final Review? review;
  final Comment? comment;
  final String? id;
  final bool? isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible ?? true,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Reviews',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'D-DIN Exp',
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text(
                    '${review?.averageRating?.toStringAsFixed(1)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'D-DIN Exp',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Icon(
                    Icons.star,
                    color: Colors.black,
                    size: 14,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    '(${review?.totalRatings})',
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
            Container(
              padding: const EdgeInsets.all(14),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: disableColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${comment?.firstName} ${comment?.lastName}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'D-DIN Exp',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          comment?.createdAt?.getTimeAgo() ?? '',
                          style: const TextStyle(
                            color: Color(0xFF6D6D6D),
                            fontSize: 14,
                            fontFamily: 'D-DIN Exp',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RatingBar(
                    itemSize: 20,
                    initialRating: comment?.starRating?.toDouble() ?? 0.0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star,
                        color: gold,
                      ),
                      half: Icon(Icons.star_half, color: gold),
                      empty: Icon(Icons.star_border, color: gold),
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  const SizedBox(height: 10),
                  Text(
                    comment?.comments ?? '',
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
            Container(
              margin: const EdgeInsets.only(top: 14, bottom: 20),
              child: InkWell(
                onTap: () {
                  Get.to(() => ReviewPage(), arguments: [id]);
                },
                child: const Text(
                  'See all reviews',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'D-DIN Exp',
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
