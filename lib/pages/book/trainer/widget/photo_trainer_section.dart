import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/trainer/detail/trainer_detail_controller.dart';

import '../../../../utils/widgets/empty/empty_photo.dart';
import '../../../../utils/widgets/loading/loading.dart';

class PhotoTrainerSection extends StatelessWidget {
  const PhotoTrainerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrainerDetailController>();
    return Center(
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          child: CachedNetworkImage(
            height: 120,
            width: 120,
            imageUrl: controller.trainer.value?.imageUrl ?? '',
            placeholder: (context, url) => const Loading(
              marginHorizontal: 0,
            ),
            errorWidget: (context, url, error) {
              final firstName = controller.trainer.value?.firstName?[0] ?? '';
              final lastName = controller.trainer.value?.lastName?[0] ?? '';
              return Center(
                  child: EmptyPhoto(
                initialName: '$firstName$lastName',
                sizePhoto: 120,
                sizeFont: 20,
              ));
            },
            fit: BoxFit.cover,
          )),
    );
  }
}
