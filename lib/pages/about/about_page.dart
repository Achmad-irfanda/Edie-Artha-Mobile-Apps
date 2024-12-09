import 'package:eam_app/bloc/user/user_bloc.dart';
import 'package:eam_app/common/constant/colors.dart';
import 'package:eam_app/common/constant/icons.dart';
import 'package:eam_app/common/constant/images.dart';
import 'package:eam_app/pages/about/dev_page.dart';
import 'package:eam_app/pages/about/eam_page.dart';
import 'package:eam_app/pages/about/password_page.dart';
import 'package:eam_app/pages/about/profile_page.dart';
import 'package:eam_app/pages/about/widget/about_item.dart';
import 'package:eam_app/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/logout/logout_bloc.dart';
import '../../data/datasource/auth_local_datasource.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  // DIALOG
  Future<void> showLogoutDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width - (2 * 20),
        child: BlocConsumer<LogoutBloc, LogoutState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (message) {
                AuthLocalDatasource().removeAuthData();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }), (route) => false);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Logout Berhasil'),
                  backgroundColor: Colors.green,
                ));
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                ));
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return AlertDialog(
                  backgroundColor: ColorName.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: ColorName.black,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          IconName.alert,
                          color: Colors.red,
                          width: 80,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Keluar?',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'apa kamu yakin untuk keluar?',
                          style: GoogleFonts.inter(fontSize: 12),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              height: 44,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: ColorName.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Tidak',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 44,
                              child: TextButton(
                                onPressed: () {
                                  context
                                      .read<LogoutBloc>()
                                      .add(const LogoutEvent.logout());
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Yakin',
                                  style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              loading: () {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  content: Container(
                    height: 150,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SingleChildScrollView(
                            child: CircularProgressIndicator(),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Loading....',
                            style: GoogleFonts.inter(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserBloc>().add(UserEvent.user());
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 50),
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(22),
            bottomRight: Radius.circular(22),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff02F80B),
              Color(0xff194E1A),
            ], // Warna gradien
          ),
        ),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return state.maybeWhen(orElse: () {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: AssetImage(Images.user),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 30,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          'Nama Pengguna',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: ColorName.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'No Handphone',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: ColorName.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Email',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: ColorName.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }, loaded: (data) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: NetworkImage(data.data!.user!.image ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 30,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          data.data!.user!.name ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: ColorName.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data.data!.user!.nohp ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: ColorName.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          data.data!.user!.email ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: ColorName.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            });
          },
        ),
      );
    }

    Widget akun() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informasi Akun',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return state.maybeWhen(orElse: () {
                  return SizedBox();
                }, loaded: (data) {
                  return Column(
                    children: [
                      AboutItem(
                        icon: IconName.user,
                        label: 'Edit Profile',
                        press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              user: data.data!.user!,
                            ),
                          ),
                        ),
                      ),
                      AboutItem(
                        icon: IconName.password,
                        label: 'Ubah Password',
                        press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PasswordPage(
                              user: data.data!.user!,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
              },
            ),
          ],
        ),
      );
    }

    Widget info() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informasi Aplikasi',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AboutItem(
              icon: IconName.shop,
              label: 'Edie Arta Motor',
              press: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => EamPage())),
            ),
            AboutItem(
              icon: IconName.dev,
              label: 'Developer Aplikasi',
              press: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DevPage())),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Container(
          child: Column(
        children: [
          header(),
          SizedBox(
            height: 30,
          ),
          Expanded(
              child: Column(
            children: [
              akun(),
              SizedBox(
                height: 20,
              ),
              info(),
            ],
          )),
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30, bottom: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: showLogoutDialog,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Logout',
                        style: GoogleFonts.inter(
                          color: ColorName.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
