import 'package:eam_app/common/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutItem extends StatelessWidget {
  final String label;
  final String icon;
  final Function() press;
  const AboutItem(
      {super.key,
      required this.label,
      required this.icon,
      required this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: press,
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            thickness: 1,
            color: ColorName.grey.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
