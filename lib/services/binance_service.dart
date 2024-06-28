import 'dart:convert';
import 'package:http/http.dart' as http;

class BinanceService {
  final String baseUrl = "https://api.binance.com/api/v3/klines";

  Future<Map<String, dynamic>> getKlines(String symbol, String interval, int limit) async {
    final response = await http.get(Uri.parse("$baseUrl?symbol=$symbol&interval=$interval&limit=$limit"));
    
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return {'data': data, 'success': true};
    } else {
      throw Exception("Failed to load klines");
    }
  }

  Future<Map<String, dynamic>> get1HourKlines(String symbol) async {
    String formattedSymbol = "${symbol.toUpperCase()}USDT";
    try {
      Map<String, dynamic> result = await getKlines(formattedSymbol, "1m", 60);
      return result;
    } catch (e) {
      return {'data': [], 'success': false, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> get1DayKlines(String symbol) async {
    String formattedSymbol = "${symbol.toUpperCase()}USDT";
    try {
      Map<String, dynamic> result = await getKlines(formattedSymbol, "5m", 288);
      return result;
    } catch (e) {
      return {'data': [], 'success': false, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> get1WeekKlines(String symbol) async {
    String formattedSymbol = "${symbol.toUpperCase()}USDT";
    try {
      Map<String, dynamic> result = await getKlines(formattedSymbol, "30m", 336);
      return result;
    } catch (e) {
      return {'data': [], 'success': false, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> get1MonthKlines(String symbol) async {
    String formattedSymbol = "${symbol.toUpperCase()}USDT";
    try {
      Map<String, dynamic> result = await getKlines(formattedSymbol, "2h", 360);
      return result;
    } catch (e) {
      return {'data': [], 'success': false, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> get1YearKlines(String symbol) async {
    String formattedSymbol = "${symbol.toUpperCase()}USDT";
    try {
      Map<String, dynamic> result = await getKlines(formattedSymbol, "1d", 365);
      return result;
    } catch (e) {
      return {'data': [], 'success': false, 'error': e.toString()};
    }
  }
}