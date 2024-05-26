import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../models/criptomoneda.dart';

class BinanceService {
  Future<List<Criptomoneda>> fetchCriptomonedas() async {
    final response =
        await http.get(Uri.parse('http://yourbackend.com/api/criptomonedas'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Criptomoneda.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load criptomonedas');
    }
  }
}
