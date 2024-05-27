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
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCriptomonedas();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _loadCriptomonedas() async {
    // List of symbols to fetch
    final List<String> symbols = ['1000SATSFDUSD', 'ETHUSD', 'BTCUSD'];

    try {
      List<Criptomoneda> criptomonedas = [];
      for (String symbol in symbols) {
        Criptomoneda criptomoneda =
            await _binanceService.fetchCriptomoneda(symbol);
        criptomonedas.add(criptomoneda);
      }
      setState(() {
        _criptomonedas = criptomonedas;
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
      _criptomonedas = _criptomonedas
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
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          labelText: 'Buscar criptomoneda',
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _criptomonedas.length,
                    itemBuilder: (context, index) {
                      Criptomoneda criptomoneda = _criptomonedas[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(criptomoneda.symbol),
                          subtitle:
                              Text('Último precio: ${criptomoneda.lastPrice}'),
                        ),
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
