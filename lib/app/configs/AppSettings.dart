// ignore_for_file: use_build_context_synchronously, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_api/app/models/setup_model.dart';

class AppSettings extends ChangeNotifier {
  late SharedPreferences _prefs;
  late Map<String, dynamic> _conta;

  Map<String, dynamic> get conta => _conta;

  factory AppSettings.create() => AppSettings._();

  AppSettings._() {
    _conta = {
      'username': '',
      'isAuth': false,
      'setupModel': null,
    };
    _startSettings();
  }

  Future<void> _startSettings() async {
    await _startPreferences();
    await _readLocale();
  }

  Future<void> _startPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _readLocale() async {
    final username = _prefs.getString('username') ?? '';
    final isAuth = _prefs.getBool('isAuth') ?? false;
    final setupModelJson = _prefs.getString('setupModel');
    SetupModel? setupModel;
    if (setupModelJson != null) {
      final decodedJson = jsonDecode(setupModelJson);
      setupModel = SetupModel.fromJson(decodedJson);
    }
    _conta = {
      'username': username,
      'isAuth': isAuth,
      'setupModel': setupModel,
    }; //Atualiza a Conta
    notifyListeners();
  }

  Future<void> setLocale(String username, bool isAuth, setupModelJson) async {
    await _prefs.setString('username', username);
    await _prefs.setBool('isAuth', isAuth);

    if (setupModelJson != null) {
      final jsonString = jsonEncode(setupModelJson);
      await _prefs.setString('setupModel', jsonString);
    }
    await _readLocale(); // Ira atualizar as informações
  }

  
}
