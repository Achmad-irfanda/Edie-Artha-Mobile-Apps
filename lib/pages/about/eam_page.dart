import 'package:eam_app/common/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/constant/images.dart';

class EamPage extends StatelessWidget {
  const EamPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tentang Edie Arta Motor',
          style: GoogleFonts.iceland(
            color: ColorName.black,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff02F80B),
                Color(0xff194E1A),
              ], // Warna gradien
            ),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip
                  .none, // Add this line to ensure the circle can be positioned outside the stack
              children: [
                // Background container for profile description
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * 0.7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Space for profile picture
                      Text(
                        'Edie Arta Motor',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          color: ColorName.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Edie Arta Motor berdiri pada tahun 2006 oleh bapak Made Putra Edi selaku owner dari Edie Arta Motor. Perusahaan ini didirikan dengan misi sebagai supplier sparepart terbesar di Bali, bahkan seluruh Indonesia. Edie Arta Motor juga menjalin kerjasama dengan beberapa perusahaan seperti, Astra International, Astra Autopart , IRC Radiva, Yamah a Bisma, dan lain lain. Edie Arta Motor merupakan satu satunya perusahaan yang bergerak dibidang otomotif dengan berbagai divisi. Adapun divisinya sebagai berikut divisi retail dan servi ce , divisi grosir ditempat, divisi grosir kelilingan, divisi cuci moto r, divisi online, divisi kantin. Edie Arta Motor memperluas jaringan perusahaannya dengan membuka beberapa cabang di Kabupaten Buleleng. Berikut merupakan cabang perusahaan Edie Arta Motor.',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                // Profile picture
                Positioned(
                  top:
                      -50, // Adjust this value to position the circle above the container
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                      image: DecorationImage(
                        image: AssetImage(Images.logo),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Colors.white,
                        width: 4.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
