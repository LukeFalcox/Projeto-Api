// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_api/app/app_service_setup.dart';
import 'package:teste_api/app/configs/AppSettings.dart';
import 'package:teste_api/app/models/transformador.dart';
import 'package:teste_api/pages/edit.dart';
import 'package:teste_api/pages/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:teste_api/widgets/splashScreen.dart';
import 'pages/login.dart';
import 'package:web/web.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  final appSettings = AppSettings.create();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppService(appSettings),
        ),
        ChangeNotifierProvider(
          create: (context) => appSettings,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      routes: {
  '/': (context) => const Login(),
  '/home': (context) => Home(),
  '/edit': (context) {
  final args = ModalRoute.of(context)!.settings.arguments;
  return Edit(filtroModel: args as FiltroModel);
},
},
    );
  }
}


 