import 'package:eam_app/bloc/user/user_bloc.dart';
import 'package:eam_app/common/constant/colors.dart';
import 'package:eam_app/data/models/response/user_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/widget/rounded_password_field.dart';

class PasswordPage extends StatefulWidget {
  final User user;
  const PasswordPage({super.key, required this.user});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final formkey = GlobalKey<FormState>();
  // TEXT EDITING CONTROLLER
  TextEditingController currentPassController = TextEditingController(text: '');
  TextEditingController newPassController = TextEditingController(text: '');
  TextEditingController confrimNewPassController =
      TextEditingController(text: '');
  bool isLoading = false;

  // GANTI KATA SANDI
  handleChangePassword() async {
    String password = currentPassController.text.trim();
    String newPassword = newPassController.text.trim();

    context
        .read<UserBloc>()
        .add(UserEvent.changePassword(password, newPassword));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Ganti Password',
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
              colors: const [
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
                  height: size.height * 0.5,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Form(
                          key: formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              RoundedPasswordField(
                                controller: currentPassController,
                                label: 'Password Sekarang',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Masukkan kata sandi saat ini";
                                  }
                                  return null;
                                },
                              ),
                              RoundedPasswordField(
                                controller: newPassController,
                                label: 'Password Baru',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Masukkan kata sandi baru";
                                  }
                                  // at least 7 char
                                  if (value.length < 5) {
                                    return 'Kata sandi minimal 6 karakter';
                                  }
                                  return null;
                                },
                              ),
                              RoundedPasswordField(
                                controller: confrimNewPassController,
                                label: 'Konfirmasi Password',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Masukkan ulang kata sandi baru";
                                  }

                                  // at least 7 char
                                  if (value != newPassController.text) {
                                    return 'Kata sandi baru tidak sama';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20, left: 20, bottom: 20),
                        child: Column(
                          children: [
                            BlocConsumer<UserBloc, UserState>(
                              listener: (context, state) {
                                state.maybeWhen(
                                  orElse: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Password berhasil diubah'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  },
                                  loading: () {
                                    Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  error: (message) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Password saat ini salah'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  },
                                  loaded: (data) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Profil berhasil diupdate'),
                                      backgroundColor: Colors.green,
                                    ));
                                  },
                                );
                              },
                              builder: (context, state) {
                                return GestureDetector(
                                  onTap: () {
                                    if (formkey.currentState!.validate()) {
                                      handleChangePassword();
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: ColorName.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Simpan',
                                        style: GoogleFonts.inter(
                                          color: ColorName.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Profile picture
                Positioned(
                  top:
                      -50, // Adjust this value to position the circle above the container
                  child: Column(
                    children: [
                      Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                          image: DecorationImage(
                            image: NetworkImage(widget.user.image ?? ''),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.white,
                            width: 4.0,
                          ),
                        ),
                      )
                    ],
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
