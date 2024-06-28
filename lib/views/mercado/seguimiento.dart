import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;



class CryptoProvider with ChangeNotifier {
  final _channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080/ws'));
  Map<String, List<dynamic>> _cryptos = {'popular': [], 'new': []};
  bool _loading = true;
  String? _error;

  CryptoProvider() {
    _connectWebSocket();
  }

  Map<String, List<dynamic>> get cryptos => _cryptos;
  bool get loading => _loading;
  String? get error => _error;

  void _connectWebSocket() {
    _channel.stream.listen((data) {
      final parsedData = jsonDecode(data);
      _cryptos = {
        'popular': parsedData['popular'].values.toList(),
        'new': parsedData['new'].values.toList(),
      };
      _loading = false;
      _error = null;
      notifyListeners();
    }, onError: (error) {
      _error = "No se ha podido conectar con el servidor";
      _loading = false;
      notifyListeners();
      _reconnect();
    }, onDone: () {
      if (_loading) {
        _error = "No se ha podido conectar con el servidor";
      }
      notifyListeners();
      _reconnect();
    });
  }

  void _reconnect() {
    Future.delayed(Duration(seconds: 3), () {
      _channel.sink.close(status.goingAway);
      _connectWebSocket();
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}



class CryptoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CryptoProvider>(context);
    final cryptos = provider.cryptos;
    final loading = provider.loading;
    final error = provider.error;

    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(
          child: Text(error!),
        ),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Crypto List'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Popular'),
              Tab(text: 'New Inclusion'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CryptoTab(cryptos: cryptos['popular']),
            CryptoTab(cryptos: cryptos['new']),
          ],
        ),
      ),
    );
  }
}

class CryptoTab extends StatelessWidget {
  final List<dynamic>? cryptos;

  CryptoTab({this.cryptos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cryptos?.length ?? 0,
      itemBuilder: (context, index) {
        final crypto = cryptos![index];
        return ListTile(
          leading: Image.network(crypto['icon']),
          title: Text(crypto['name']),
          subtitle: Text('\$${crypto['price']}'),
          trailing: Text(
            '${crypto['change']}%',
            style: TextStyle(
              color: double.parse(crypto['change']) > 0 ? Colors.green : Colors.red,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CryptoDetail(symbol: crypto['symbol']),
              ),
            );
          },
        );
      },
    );
  }
}

class CryptoDetail extends StatelessWidget {
  final String symbol;

  CryptoDetail({required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(symbol.toUpperCase()),
      ),
      body: Center(
        child: Text('Detail page for $symbol'),
      ),
    );
  }
}
