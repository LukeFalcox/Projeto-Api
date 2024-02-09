// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:teste_api/app/configs/AppSettings.dart';
import 'package:teste_api/app/models/setup_model.dart';
import 'package:teste_api/app/models/transformador.dart';
import 'package:teste_api/pages/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppService extends ChangeNotifier {
  SetupModel? _setupModel;
  SetupModel? get setupModel => _setupModel;

  FiltroModel? filtroModel;

  AppService(this._appSettings);

  late List<MapEntry<String, String>> listTiles = [];
  late List<String> expansionTile = [];
  late List<Widget> widgetList = [];

  AppSettings _appSettings;
  String? endpoint;
  String? token;
  String? userID;
  BuildContext? context;
  Map<String, dynamic>? menus;
  String? contUrl;
  String? cont_Url;

/* ------------------------------------------------*/
/* ------------------------------------------------*/
/* ------------------- Parte 1 --------------------*/
/* ------------------------------------------------*/
/* ------------------------------------------------*/
  Future<void> tryLogin(String username, String password, String alias) async {
    await dotenv.load(fileName: ".env");
    cont_Url = dotenv.env['REMOVER_URL'];
    contUrl = dotenv.env['REMOVERURL'];
    String? url = dotenv.env['API'];
    final response = await Dio()
        .post('${url!}usuario=$username&senha=$password&alias=$alias');
    _setupModel = SetupModel.fromJson(response.data);

    notifyListeners();
  }

/* ------------------------------------------------*/
/* ------------------------------------------------*/
/* ------------------- Parte 2 --------------------*/
/* ------------------------------------------------*/
/* ------------------------------------------------*/

  Future<Response> getRotina(String? rotina) async {
    await dotenv.load(fileName: ".env");
    if (_appSettings.conta['setupModel'] == null) {
      throw Exception('O objeto setupModel é nulo.');
    }

    endpoint = _appSettings.conta['setupModel']!.endpoint;
    token = _appSettings.conta['setupModel']!.token;
    userID = _appSettings.conta['setupModel']!.userID;

    final dio = Dio();
    var url = "http://$endpoint/$rotina";
    print('Antiga Url:$url');
    if (url.contains(contUrl!)) {
      url = removerSubstring(url, contUrl!);
      print('Nova URL:$url');
    } else if (url.contains(cont_Url!)) {
      url = removerSubstring(url, cont_Url!);
      print('Nova URL:$url');
    }

    final response = await dio.get(
      url,
      options: Options(
        headers: {
          'Token': token,
          'userID': userID,
        },
      ),
    );
    return response;
  }

  String removerSubstring(String original, String substring) {
    return original.replaceAllMapped(
      RegExp(
        substring,
        caseSensitive: false,
      ),
      (match) => '',
    );
  }

  Future<void> logout(BuildContext context) async {
    await _appSettings.setLocale('', false, null);
    _navigateToLogin(context);
    print('Logout realizado. Navegar para Login');
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
    print('Navegar para Login.');
  }
}







  

  // ListTile criadorList(String key, String valor) {
  //   return ListTile(
  //     title: Text(key),
  //   );
  // }

/*
var url = Uri.parse(
        );

    var response = await http.post(url);
    print('Resposta do servidor: ${response.statusCode} ${response.body}');
    _setupModel = SetupModel.fromJson(jsonDecode(response.body));
    
*/

/*

Future<void> endpoint(baseEndpoint,subPath,token,userID) async {
   

    final response = await Dio().get(url);

    print(response.data);
  }


*/
