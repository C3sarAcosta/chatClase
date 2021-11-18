import 'dart:convert';

import 'package:chat/global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  Usuario? usuario;
  Future login(String email, String password) async {
    //Payload que mandaremos al backend
    final data = {'email': email, 'password': password};
    final uri = Uri.parse('${Environment.apiUrl}/login/');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    //Si la operacion con el servidor es exitosa
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      //almacenamos el usuario autenticado
      this.usuario = loginResponse.usuario;
    }
    print(resp.body);
  }
}
