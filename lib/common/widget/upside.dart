import 'package:eam_app/common/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Upside extends StatelessWidget {
  const Upside({super.key, required this.imgUrl});
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorName.green,
                Color(0xff04340B),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Image.asset(
              imgUrl,
              alignment: Alignment.topCenter,
              scale: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
