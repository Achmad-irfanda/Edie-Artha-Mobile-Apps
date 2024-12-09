import 'package:eam_app/common/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final IconData icon;
  final bool isPhoneNumber;
  final keyboardType;
  final validator;
  const RoundedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    this.controller,
    this.validator,
    this.isPhoneNumber = false,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        maxLength: isPhoneNumber ? 15 : null,
        inputFormatters: [
          isPhoneNumber
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter
        ],
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: ColorName.green,
        validator: validator,
        decoration: InputDecoration(
          errorStyle: const TextStyle(height: 0),
          icon: Icon(
            icon,
            color: ColorName.green,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(fontFamily: 'OpenSans'),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
