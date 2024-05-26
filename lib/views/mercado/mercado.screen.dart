import 'package:flutter/material.dart';
import '../../services/binance_service.dart';
import '../../models/criptomoneda.dart';

class MercadoScreen extends StatefulWidget {
  const MercadoScreen({super.key});

  @override
  _MercadoScreenState createState() => _MercadoScreenState();
}

class _MercadoScreenState extends State<MercadoScreen> {
  final BinanceService _binanceService = BinanceService();
  List<Criptomoneda> _criptomonedas = [];
  List<Criptomoneda> _filteredCriptomonedas = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCriptomonedas();
    _searchController.addListener(_onSearchChanged);
  }

  void _loadCriptomonedas() async {
    try {
      List<Criptomoneda> criptomonedas =
          await _binanceService.fetchCriptomonedas();
      setState(() {
        _criptomonedas = criptomonedas;
        _filteredCriptomonedas = criptomonedas;
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching criptomonedas: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    setState(() {
      _filteredCriptomonedas = _criptomonedas
          .where((cripto) => cripto.symbol
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mercado page'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Buscar criptomoneda',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredCriptomonedas.length,
                    itemBuilder: (context, index) {
                      Criptomoneda criptomoneda = _filteredCriptomonedas[index];
                      return ListTile(
                        title: Text(criptomoneda.symbol),
                        subtitle:
                            Text('Último precio: ${criptomoneda.lastPrice}'),
                      );
                    },
                  ),
                ),
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Mercado page'),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
