import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/criptomoneda.dart';

class BinanceService {
  Future<Criptomoneda> fetchCriptomoneda(String symbol) async {
    final response = await http.get(Uri.parse(
        'https://template-go-vercel-xi-two.vercel.app/api/cryptoprice/?symbol=$symbol'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return Criptomoneda.fromJson(symbol, data);
    } else {
      throw Exception('Failed to load criptomoneda');
    }
  }
}
