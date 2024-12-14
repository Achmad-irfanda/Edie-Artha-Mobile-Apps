// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:eam_app/bloc/login/login_bloc.dart';
import 'package:eam_app/data/datasource/auth_local_datasource.dart';
import 'package:eam_app/pages/auth/register_page.dart';
import 'package:eam_app/pages/navigation/navigation_page.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/constant/colors.dart';
import '../../common/widget/rounded_button.dart';
import '../../common/widget/rounded_input_field.dart';
import '../../common/widget/rounded_password_field.dart';
import '../../common/widget/under_part.dart';
import '../../common/widget/upside.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isDisabledBtn = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateFields);
    _passwordController.addListener(_validateFields);
  }

  void _validateFields() async {
    final email = _emailController.text;
    final pass = _passwordController.text;

    // Cek validasi di sini, misalnya, jika kedua TextField harus diisi.
    bool isValid = email.isNotEmpty && pass.isNotEmpty;

    setState(() {
      _isDisabledBtn = isValid;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Silahkan masukkan Email dan Kata sandi'),
        backgroundColor: Colors.red,
      ));
    } else {
      context.read<LoginBloc>().add(LoginEvent.login(email, password));
    }
  }

  Widget buttonComp() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            loaded: (data) async {
              await AuthLocalDatasource().saveAuthData(data);
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return NavigationPage();
                }), (route) => false);
              }
            },
            error: (message) {
              return ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(message),
                ),
              );
            });
      },
      builder: (context, state) {
        return state.maybeWhen(orElse: () {
          return RoundedButton(
            text: 'LOGIN',
            press: login,
          );
        }, loading: () {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(gradient: linearBackround),
          child: SingleChildScrollView(
            child: Column(
              children: [
                jar(sized: 40),
                imgLogoPage(),
                jar(sized: 28),
                Container(
                  constraints: BoxConstraints(maxHeight: size.height - 100),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        jar(sized: 20),
                        Text(
                          "Login",
                          style: GoogleFonts.iceland(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "Selamat Datang di Edie Arta Motor",
                          style: GoogleFonts.iceland(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: ColorName.grey,
                          ),
                        ),
                        jar(sized: 20),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              RoundedInputField(
                                controller: _emailController,
                                hintText: "Email",
                                icon: IconsaxBold.sms,
                              ),
                              RoundedPasswordField(
                                controller: _passwordController,
                              ),
                              buttonComp(),
                              const SizedBox(
                                height: 10,
                              ),
                              UnderPart(
                                title: "Belum punya akun?",
                                navigatorText: "Register disini",
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage()));
                                },
                              ),
                              jar(sized: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                jar(sized: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
