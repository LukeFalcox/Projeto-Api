// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_api/app/configs/AppSettings.dart';
import 'package:teste_api/pages/home.dart';
import 'package:teste_api/pages/login.dart';

class SplashScreen extends StatefulWidget {
  static SplashScreen _instance = SplashScreen._();
  static SplashScreen get instance => _instance;
  const SplashScreen._({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


   @override
  Widget build(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, appSettings, child) {
        if (appSettings.conta['isAuth'] == true) {
          return Home.instance;
        } else {
          return Login.instance;
        }
      },
    );
  }
}
