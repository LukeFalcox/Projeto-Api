// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teste_api/app/app_service_setup.dart';
import 'package:provider/provider.dart';
import 'package:teste_api/app/configs/AppSettings.dart';
import 'package:teste_api/app/models/Exp.dart';
import 'package:teste_api/app/models/Rotinas.dart';
import 'package:teste_api/app/models/transformador.dart';
import 'package:teste_api/widgets/buttonLogout.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
/* ------------------------------------------------*/
/* ------------------------------------------------*/
/* ------------------- Parte 1 --------------------*/
/* ------------------------------------------------*/
/* ------------------------------------------------*/


  @override
  Widget build(BuildContext context) {
    return Consumer2<AppSettings, AppService>(
      builder: (context, appSettings, appService, child) {
        return Drawer(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/app/logobersek.jpg"),
              Expanded(
                child: _buildDrawerItems(context, appSettings, appService),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: ButtonLogout(appService:appService)
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawerItems(
      BuildContext context, AppSettings appSettings, AppService appService) {
    final setupModel = appSettings.conta['setupModel'];
    final menus = setupModel != null ? setupModel.menu : {};
    

    if (menus != null) {
      List<Exp?> myExpList = items(menus);

      List<Widget> drawerItems = myExpList.map((Exp? exp) {
        if (exp != null) {
          return ExpansionTile(
            title: Text(
              exp.nome,
              style: GoogleFonts.openSans(
                  textStyle: const TextStyle(letterSpacing: .5)),
            ),
            children: exp.rotinas.map(
              (items) {
                return ListTile(
                  title: Text(
                    items.nome,
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(letterSpacing: .5)),
                  ),
                  onTap: () async {
                    final response = await appService.getRotina(items.api);
                    FiltroModel filtroModel =
                        FiltroModel.fromJson(jsonDecode(response?.data));
                    await navigateToEdit(context, filtroModel);
                  },
                );
              },
            ).toList(),
          );
        } else {
          return const SizedBox.shrink();
        }
      }).toList();

      return ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: drawerItems.length,
        itemBuilder: (BuildContext context, int index) {
          return drawerItems[index];
        },
        separatorBuilder: (_, ___) => const Divider(),
      );
    } else {
      return const Center(
        child: Text('Dados do menu não disponíveis'),
      );
    }
  }

  Color hexToColor(String hexCode) {
    String formattedHex = hexCode.replaceAll('#', '');

    int colorValue = int.parse(formattedHex, radix: 16);

    int finalColorValue = colorValue + 0xFF000000;

    return Color(finalColorValue);
  }

/* ------------------------------------------------*/
/* ------------------------------------------------*/
/* ------------------- Parte 2 --------------------*/
/* ------------------------------------------------*/
/* ------------------------------------------------*/
  List<Exp?> items(Map<String, dynamic> menus) {
    return menus.entries.map(
      (e) {
        if (e.value is Map<String, dynamic>) {
          List<Rotinas> rotinasList = (e.value['items'] as Map<String, dynamic>)
              .entries
              .map((items) => Rotinas(items.key, items.value.toString()))
              .toList();

          return Exp(e.key, rotinasList);
        } else {
          return null;
        }
      },
    ).toList();
  }
}

/* ------------------------------------------------*/
/* ------------------------------------------------*/
/* ------------------- Parte 3 --------------------*/
/* ------------------------------------------------*/
/* ------------------------------------------------*/
Future<void> navigateToEdit(BuildContext context, var filtro) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const AlertDialog(
        key: Key('authDialog'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Carregando...'),
          ],
        ),
      );
    },
  );

  try {
    await Future.delayed(const Duration(seconds: 2));

    Navigator.pop(context);
    Navigator.of(context).pushNamed('/edit', arguments: filtro);
  } catch (e) {
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Erro ao autenticar: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
