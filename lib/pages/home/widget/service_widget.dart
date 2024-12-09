import 'dart:math';

import 'package:eam_app/pages/bengkel/bengkel_page.dart';
import 'package:eam_app/pages/navigation/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/constant/colors.dart';

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 170,
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        vertical: 30,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: ColorName.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menerima \nService Panggilan',
                  style: GoogleFonts.inter(
                    color: ColorName.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '08:00 - 22:00 WITA',
                  style: GoogleFonts.inter(
                    color: ColorName.black,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationPage(
                                index: 2,
                              )),
                      (route) => false),
                  child: Container(
                    height: 35,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: ColorName.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('PESAN SEKARANG',
                          style: GoogleFonts.inter(
                            color: ColorName.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Image.asset('assets/images/service.png')
        ],
      ),
    );
  }
}
