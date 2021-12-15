import 'package:chat/global/environment.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  Usuario? usuarioDestino;
  Future<List<Mensaje>> getChat(String usuarioId) async {
    String? token = await AuthService.getToken();
    final uri = Uri.parse('${Environment.apiUrl}/mensajes/$usuarioId');
    final resp = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString()
      },
    );

    final mensajeResponse = mensajesResponseFromJson(resp.body);
    return mensajeResponse.mensajes;
  }
}
