import 'package:eam_app/common/constant/colors.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: ColorName.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.green, // Border color
          width: 1, // Border width
        ),
      ),
      child: child,
    );
  }
}
