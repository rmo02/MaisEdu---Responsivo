import 'package:flutter/foundation.dart';
import 'package:resposividade/services/prefs_service.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:flutter/material.dart';

class LoginController {
  ValueNotifier<bool> inLoader = ValueNotifier<bool>(false);

  late String _login;

  setLogin(String value) => _login = value;

  late String _pass;

  setPass(String value) => _pass = value;
  late var dados;
  late var result;

void login(String mat, password) async {
    try {
      Response response = await post(
        Uri.parse('http://192.168.6.20:3010/escolas/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'mat': mat,
          'password': password
        }),
      );

      if (response.statusCode == 200) {
        dados = jsonDecode(response.body);
        result = dados[0]['data']['token'];
        PrefsService.save(dados[0]['data']['token']);
        print(result);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
