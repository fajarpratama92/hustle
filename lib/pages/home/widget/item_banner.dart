import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemBanner extends StatelessWidget {
  const ItemBanner(
      {super.key, this.image, this.title, this.description, this.onTap});

  final String? image;
  final String? title;
  final String? description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          CachedNetworkImage(
              imageUrl: image ?? '',
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  )),
          Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: <Color>[
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0)
                  ]),
            ),
          ),
          Positioned(
            bottom: 39,
            left: 40,
            right: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'D-DIN Exp',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  description ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'D-DIN Exp',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
