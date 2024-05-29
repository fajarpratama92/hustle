import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hustle_house_flutter/utils/colors.dart';

import '../../profile/editprofile/edit_profile_controller.dart';

class GenderDropdown extends StatefulWidget {
  final String label;
  final List<String> genders;
  final String? selectedGender;
  final String? hint;
  final Function(String) onGenderChanged;



  GenderDropdown({
    Key? key,
    required this.label,
    required this.genders,
    this.selectedGender,
    required this.onGenderChanged, this.hint,
  }) : super(key: key);

  @override
  _GenderDropdownState createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String? selectedGender;

  final EditProfileController editProfileController = Get.put(EditProfileController());

  @override
  void initState() {
    super.initState();
    selectedGender = widget.selectedGender;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: widget.label,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'D-DIN Exp',
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        DropdownButtonFormField<String>(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          hint: Text(widget.hint??"",
              style: TextStyle(
                  color: gray,
                  fontSize: 14,
                  fontFamily: 'D-DIN Exp',
                  fontWeight: FontWeight.w400)),
          value: selectedGender,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: gray.withOpacity(0.3),  width: 2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: gray.withOpacity(0.3), width: 2),
            ),
          ),
          items: widget.genders
              .map((gender) => DropdownMenuItem<String>(
                    child: Text(gender),
                    value: gender,
                  ))
              .toList(),
          onChanged: (gender) {
            setState(() {
              selectedGender = gender;
            });
            widget.onGenderChanged(gender!);
            editProfileController.gender.value = gender;
          },
        ),
      ],
    );
  }
}
