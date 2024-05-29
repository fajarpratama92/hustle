import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/editprofile/edit_profile_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/colors.dart';
import '../../../utils/widgets/custom_dialog.dart';
import '../../profile_controller.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  ImagePickerBottomSheet({
    super.key,
  });

  final EditProfileController controller = Get.put(EditProfileController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.chevron_left_outlined,
                  size: 28,
                ),
                color: Colors.black,
                onPressed: () {
                  Get.back();
                },
              ),
              const Expanded(
                child: Text(
                  'Choose Image Source',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'D-DIN Exp',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          ),
          Divider(thickness: 10, color: gray1),
          Container(
            child: TextButton(
              child: const Text(
                'Camera',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                controller.pickImage(source: ImageSource.camera);
                Navigator.pop(context);
              },
            ),
          ),
          Divider(thickness: 1, color: gray1),
          Container(
            child: TextButton(
              child: const Text(
                'Gallery',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                controller.pickImage(source: ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ),
          Divider(thickness: 1, color: gray1),
          if (profileController.userProfile.value?.member?.imageUrl !=
              'https://hustle-web.cranium.id/images/members/')
            Container(
              child: TextButton(
                child: const Text(
                  'Delete image',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontFamily: 'D-DIN Exp',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Get.dialog(CustomDialog().alert("Delete photo",
                      "are you sure you want to delete your photo?", () {
                    Get.back();
                  }, () {
                    controller.deleteImage();
                  }));
                },
              ),
            ),
        ],
      ),
    );
  }
}
