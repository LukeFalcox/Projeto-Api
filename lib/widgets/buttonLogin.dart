// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_api/app/app_service_setup.dart';
import 'package:teste_api/app/configs/AppSettings.dart';

class ButtonLogin extends StatelessWidget {
  final String nameController;
  final String passwordController;
  final String aliasController;

  const ButtonLogin({
    super.key,
    required this.nameController,
    required this.passwordController,
    required this.aliasController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('TESTE'), 
  onPressed: () async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  const AlertDialog(// Defina a chave aqui
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('Autenticando...'),
            ],
          ),
        );
      },
    );
        final appService = Provider.of<AppService>(context, listen: false);
        final appSettings = Provider.of<AppSettings>(context, listen: false);

        try {
          await appService.tryLogin(
            nameController,
            passwordController,
            aliasController,
          );

          await appSettings.setLocale(
            nameController,
            true,
            appService.setupModel,
          );

          Navigator.pop(context);

         Navigator.of(context).pushNamed('/home',);
        } catch (error) {
          Navigator.pop(context);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('Erro ao autenticar: $error'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: const Text('Confirmar'),
    );
  }
}
