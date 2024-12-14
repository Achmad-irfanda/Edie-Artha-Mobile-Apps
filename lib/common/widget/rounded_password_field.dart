import 'package:eam_app/common/constant/colors.dart';
import 'package:flutter/material.dart';

import 'text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final validator;
  const RoundedPasswordField(
      {Key? key,
      required this.controller,
      this.label = 'Password',
      this.validator})
      : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool hide = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldContainer(
          child: TextFormField(
            obscureText: hide,
            cursorColor: ColorName.green,
            validator: widget.validator,
            controller: widget.controller,
            decoration: InputDecoration(
              errorStyle: TextStyle(height: 0),
              icon: Icon(
                Icons.lock,
                color: ColorName.green,
              ),
              hintText: widget.label,
              hintStyle: TextStyle(fontFamily: 'OpenSans'),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    hide = !hide;
                  });
                },
                child: Icon(
                  hide ? Icons.visibility : Icons.visibility_off,
                  color: ColorName.green,
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
  
        TextFieldContainer(
          child: TextFormField(
            obscureText: hide,
            cursorColor: ColorName.green,
            validator: widget.validator,
            controller: widget.controller,
            decoration: InputDecoration(
              errorStyle: TextStyle(height: 0),
              icon: Icon(
                Icons.lock,
                color: ColorName.green,
              ),
              hintText: widget.label,
              hintStyle: TextStyle(fontFamily: 'OpenSans'),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    hide = !hide;
                  });
                },
                child: Icon(
                  hide ? Icons.visibility : Icons.visibility_off,
                  color: ColorName.green,
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
