import 'package:eam_app/bloc/bengkel/bengkel_bloc.dart';
import 'package:eam_app/bloc/login/login_bloc.dart';
import 'package:eam_app/bloc/logout/logout_bloc.dart';
import 'package:eam_app/bloc/product/product_bloc.dart';
import 'package:eam_app/bloc/register/register_bloc.dart';
import 'package:eam_app/bloc/trx_bengkel/trx_bengkel_bloc.dart';
import 'package:eam_app/bloc/trx_product/trx_product_bloc.dart';
import 'package:eam_app/bloc/user/user_bloc.dart';
import 'package:eam_app/data/datasource/auth_remote_datasource.dart';
import 'package:eam_app/pages/auth/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => BengkelBloc(),
        ),
        BlocProvider(
          create: (context) => TrxBengkelBloc(),
        ),
        BlocProvider(
          create: (context) => TrxProductBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Edie Arta Motor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
