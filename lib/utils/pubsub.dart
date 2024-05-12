import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

Future<void> publishMessage(String message) async {
  final url = Uri.parse(
    'http://10.0.2.2:8080/publish',
  );

  try {
    if (kDebugMode) {
      print('Publicando mensaje: $message $url');
    }
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // Aquí puedes incluir el token de autenticación si es necesario
        //'Authorization': 'Bearer tu_token_de_autenticacion',
      },
      body: jsonEncode(<String, String>{
        'message': message,
      }),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Mensaje publicado correctamente $url');
      }
    } else {
      if (kDebugMode) {
        print('Error al publicar mensaje: ${response.reasonPhrase}');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error al realizar la solicitud: $e');
    }
  }
}
