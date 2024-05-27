import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CryptoPriceDisplay extends StatefulWidget {
  final String symbol;

  CryptoPriceDisplay({required this.symbol});

  @override
  _CryptoPriceDisplayState createState() => _CryptoPriceDisplayState();
}

class _CryptoPriceDisplayState extends State<CryptoPriceDisplay> {
  String _price = '';
  bool _loading = false;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchPrice();
  }

  Future<void> _fetchPrice() async {
    setState(() {
      _loading = true;
      _error = '';
    });

    final url =
        'https://template-go-vercel-xi-two.vercel.app/api/cryptoprice/?symbol=${widget.symbol}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _price = data['price'].toString();
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Error: ${response.reasonPhrase}';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return CircularProgressIndicator();
    } else if (_error.isNotEmpty) {
      return Text(_error, style: TextStyle(color: Colors.red));
    } else {
      return Text('Price of ${widget.symbol}: $_price',
          style: TextStyle(fontSize: 24));
    }
  }
}
