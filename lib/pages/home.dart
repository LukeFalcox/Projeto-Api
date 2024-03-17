import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_api/app/configs/AppSettings.dart';
import 'package:teste_api/widgets/NavBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, appSettings, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tela Principal'),
          ),

          drawer: const NavBar(),
          body: Center(
            child: Text(
              appSettings.conta['setupModel'].welcome ?? 'sem nada'),
              
          ),

        );

      },
    );
  }
}
