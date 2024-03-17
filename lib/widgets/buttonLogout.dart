import 'package:flutter/material.dart';
import 'package:teste_api/app/app_service_setup.dart';
import 'package:teste_api/app/configs/AppSettings.dart';
import 'package:teste_api/pages/login.dart';

class ButtonLogout extends StatelessWidget {
  final AppService appService;
  const ButtonLogout({
    super.key,
    required this.appService,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Logout'),
      leading: const Icon(Icons.logout),
      onTap: () {
        Future.delayed(Duration.zero, () {
          try {
            appService.logout(context);
          } catch (e) {
            throw Exception(e);
          }
        });
      },
    );
  }

   
}
