import 'package:eam_app/common/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextDisabledBengkel extends StatelessWidget {
  final String label;
  final String value;
  const TextDisabledBengkel(
      {super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${label} :',
            style: GoogleFonts.inter(
                color: ColorName.black,
                fontSize: 12,
                fontWeight: FontWeight.normal),
          ),
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: Text(
                value,
                style: GoogleFonts.inter(
                  color: ColorName.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
