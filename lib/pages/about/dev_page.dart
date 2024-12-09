import 'package:eam_app/common/constant/colors.dart';
import 'package:eam_app/common/constant/images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DevPage extends StatelessWidget {
  const DevPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile Developer',
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
                  height: size.height * 0.3,
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
                        'Komang Ari Suparta',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          color: ColorName.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Mahasiswa Program Studi Sistem Informasi Jurusan Teknik Informatika Fakultas Teknik dan Kejuruan Universitas Pendidikan Ganesha',
                        textAlign: TextAlign.center,
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
                        image: AssetImage(Images.ari),
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
