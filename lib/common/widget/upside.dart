import 'package:eam_app/common/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

LinearGradient linearBackround = LinearGradient(
  colors: const [
    ColorName.green,
    Color(0xff04340B),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

class Upside extends StatelessWidget {
  const Upside({super.key, required this.imgUrl, required this.forLogin});
  final String imgUrl;
  final bool forLogin;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: (forLogin) ? 
      size.height * 1.01 : size.height * 1.05,
      decoration: BoxDecoration(gradient: linearBackround),
      child: Padding(
        padding: EdgeInsets.only(top: (forLogin) ? 70 : 40),
        child: Image.asset(imgUrl,
            alignment: Alignment.topCenter, scale: (forLogin) ? 1.3 : 1.5),
      ),
    );
  }
}
