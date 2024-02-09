// ignore_for_file: use_build_context_synchronously, unused_import, unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teste_api/app/app_service_setup.dart';
import 'package:teste_api/app/configs/AppSettings.dart';
import 'package:teste_api/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:teste_api/pages/resetPasswordPage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => CreatedLogin();
}

class CreatedLogin extends State<Login> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _aliasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("assets/app/logobersek.jpg"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              cursorColor: Colors.amber,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              cursorColor: Colors.amber,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Configurações'),
                              content: SizedBox(
                                width: 300,
                                height: 116,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      keyboardType: TextInputType.text,
                                      controller: _aliasController,
                                      decoration: const InputDecoration(
                                        hintText: 'Digite o Alias',
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Confirmar'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.settings),
                      label: const Text(
                        'Configurações',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text(
                      "Recuperar Senha",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 13),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResetPassword(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 100,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
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
                            Text('Autenticando...'),
                          ],
                        ),
                      );
                    },
                  );
                  final appService =
                      Provider.of<AppService>(context, listen: false);
                  final appSettings =
                      Provider.of<AppSettings>(context, listen: false);








                  try {
                    await appService.tryLogin(
                      _nameController.text,
                      _passwordController.text,
                      _aliasController.text,
                    );

                    await appSettings.setLocale(
                      _nameController.text,
                      true,
                      appService.setupModel,
                    );

                    Navigator.pop(context);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                          value: appSettings,
                          child: const Home(),
                        ),
                      ),
                    );
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// onPressed: () {
//                 SetupModel setupModel = SetupModel("");
//                 print(namecontroller);
//                 print(passwordcontroller);
//                 print(aliascontroller);

//                 setupModel.tryLogin(
//                     namecontroller, passwordcontroller, aliascontroller);

//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ChangeNotifierProvider.value(
//                       value: setupModel,
//                       child: const Home(),
//                     ),
//                   ),
//                 );
//               },
//               child: const Text('Confirmar'),