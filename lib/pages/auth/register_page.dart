// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:eam_app/common/constant/colors.dart';
import 'package:eam_app/data/models/request/register_request_model.dart';
import 'package:eam_app/pages/auth/login_page.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/register/register_bloc.dart';
import '../../common/widget/rounded_button.dart';
import '../../common/widget/rounded_input_field.dart';
import '../../common/widget/rounded_password_field.dart';
import '../../common/widget/under_part.dart';
import '../../common/widget/upside.dart';
import '../../data/datasource/auth_local_datasource.dart';

enum TypeMessager { success, failed }

ScaffoldFeatureController messagerComponent({
  required context,
  required message,
  required TypeMessager type,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 600),
    content: Text(
      message,
      style: TextStyle(fontSize: 14),
    ),
    backgroundColor: (type == TypeMessager.success) ? Colors.green : Colors.red,
  ));
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isDisabledBtn = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateFields);
    _nameController.addListener(_validateFields);
    _phoneController.addListener(_validateFields);
    _passwordController.addListener(_validateFields);
  }

  void _validateFields() async {
    final email = _emailController.text;
    final name = _nameController.text;
    final phone = _phoneController.text;
    final pass = _passwordController.text;

    // Cek validasi di sini, misalnya, jika kedua TextField harus diisi.
    bool isValid = email.isNotEmpty &&
        name.isNotEmpty &&
        phone.isNotEmpty &&
        pass.isNotEmpty;

    setState(() {
      _isDisabledBtn = isValid;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Widget disabledButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ElevatedButton(
          onPressed: () {
            messagerComponent(
                context: context,
                message: 'Silahkan lengkapi form registrasi',
                type: TypeMessager.failed);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: ColorName.grey,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: TextStyle(
              letterSpacing: 2,
              color: ColorName.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
          child: const Text(
            'REGISTER',
            style: TextStyle(color: ColorName.white, fontSize: 17),
          ),
        ),
      ),
    );
  }

  Widget allowButtonComps() {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (message) {
            return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
          },
          loaded: (data) async {
            // Save Token
            await AuthLocalDatasource().saveAuthData(data);
            if (context.mounted) {
              messagerComponent(
                  context: context,
                  message: 'Proses Pendaftaran Berhasil, Silahkan Masuk',
                  type: TypeMessager.success);
            }
            // Future.delayed(const Duration(milliseconds: 600), () {
            //   if (context.mounted) {
            //     Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(builder: (context) => LoginPage()),
            //         (route) => false);
            //   }
            // });
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return RoundedButton(
                text: 'REGISTER',
                press: () {
                  if (_formKey.currentState!.validate()) {
                    register();
                  }
                });
          },
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void register() async {
    String email = _emailController.text.trim();
    String name = _nameController.text.trim();
    String phone = _phoneController.text.trim();
    String password = _passwordController.text.trim();

    // Bloc
    final model = RegisterRequestModel(
      name: name,
      nohp: phone,
      email: email,
      password: password,
    );
    context.read<RegisterBloc>().add(RegisterEvent.register(model));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget jarak20 = const SizedBox(
      height: 20,
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 23, 22, 22),
        body: SizedBox(
          width: size.width,
          height: size.height * 2,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(
                  forLogin: false,
                  imgUrl: "assets/images/logo.png",
                ),
                Positioned(
                  bottom: 10,
                  // padding: const EdgeInsets.only(top: 250.0),
                  right: 0,
                  left: 0,
                  child: Container(
                    constraints: BoxConstraints(maxHeight: size.height - 100),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          jarak20,
                          Text(
                            "Register",
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
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                RoundedInputField(
                                  controller: _nameController,
                                  hintText: "Nama",
                                  validator: (value) {
                                    // NULL
                                    if (value!.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Masukkan Nama Lengkap'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                    return null;
                                  },
                                  icon: IconsaxBold.user,
                                ),
                                RoundedInputField(
                                  controller: _emailController,
                                  hintText: "Email",
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    // NULL
                                    if (value!.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Masukkan Alamat Email'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return '';
                                    }
                                    // VALID EMAIL
                                    const pattern =
                                        r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                                    final regExp = RegExp(pattern);

                                    if (!regExp.hasMatch(value)) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Masukkan Email yang Valid'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return '';
                                    }
                                    return null;
                                  },
                                  icon: IconsaxBold.sms,
                                ),
                                RoundedInputField(
                                  controller: _phoneController,
                                  hintText: "No Telepon",
                                  keyboardType: TextInputType.phone,
                                  icon: IconsaxBold.call,
                                  validator: (value) {
                                    // NULL
                                    if (value!.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Masukkan Nomor Hp'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return '';
                                    }
                                    return null;
                                  },
                                ),
                                RoundedPasswordField(
                                  controller: _passwordController,
                                ),
                                if (_isDisabledBtn)
                                  allowButtonComps()
                                else
                                  disabledButton(),
                                const SizedBox(
                                  height: 10,
                                ),
                                UnderPart(
                                  title: "Sudah punya akun?",
                                  navigatorText: "Login disini",
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  },
                                ),
                                jarak20,
                              ],
                            ),
                          ),
                        ],
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
