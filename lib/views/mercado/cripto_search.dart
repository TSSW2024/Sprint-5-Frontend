import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CryptoTypeaheadWidget extends StatefulWidget {
  const CryptoTypeaheadWidget({super.key});

  @override
  CryptoTypeaheadWidgetState createState() => CryptoTypeaheadWidgetState();
}

class CryptoTypeaheadWidgetState extends State<CryptoTypeaheadWidget> {
  List<String> _symbols = [];
  String selectedSymbol = '';
  bool loadingSymbols = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    _fetchSymbols();
  }

  Future<void> _fetchSymbols() async {
    setState(() {
      loadingSymbols = true;
      error = '';
    });

    const url = 'https://template-go-vercel-xi-two.vercel.app/api/cryptoprices';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          _symbols = data.keys.toList();
          loadingSymbols = false;
        });
      } else {
        throw Exception('Failed to load symbols: ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        loadingSymbols = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loadingSymbols
        ? const Center(child: CircularProgressIndicator())
        : error.isNotEmpty
            ? Center(child: Text(error))
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: TypeAheadField<String>(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    style: DefaultTextStyle.of(context).style.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Buscar criptomoneda',
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return _symbols
                        .where((symbol) => symbol
                            .toLowerCase()
                            .contains(pattern.toLowerCase()))
                        .toList();
                  },
                  itemBuilder: (context, symbol) {
                    return ListTile(
                      title: Text(symbol),
                    );
                  },
                  onSuggestionSelected: (symbol) {
                    setState(() {
                      selectedSymbol = symbol;
                    });
                  },
                  loadingBuilder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  noItemsFoundBuilder: (context) => const Center(
                    child: Text('No se encontraron símbolos'),
                  ),
                  errorBuilder: (context, error) => Center(
                    child: Text('Ocurrió un error: $error'),
                  ),
                ),
              );
  }
}
