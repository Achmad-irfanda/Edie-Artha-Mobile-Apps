// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:eam_app/common/constant/colors.dart';
import 'package:eam_app/data/datasource/auth_local_datasource.dart';
import 'package:eam_app/pages/auth/login_page.dart';
import 'package:eam_app/pages/auth/register_page.dart';
import 'package:eam_app/pages/navigation/navigation_page.dart';
import 'package:flutter/material.dart';

import '../../common/constant/images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthLocalDatasource().isLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: ColorName.green,
            body: Center(
              child: Image.asset(
                Images.logo,
                width: 200.0,
              ),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!) {
          return NavigationPage();
        } else {
          return RegisterPage();
        }
      },
    );
  }
}
