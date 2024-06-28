import 'package:flutter/material.dart';
import 'package:ejemplo_1/widgets/grafico_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../services/binance_service.dart'; // Importa el servicio de Binance

class MonedaPage extends StatefulWidget {
  final String monedaNombre;
  final String symbol;

  const MonedaPage({Key? key, required this.monedaNombre, required this.symbol}) : super(key: key);

  @override
  _MonedaPageState createState() => _MonedaPageState();
}

class _MonedaPageState extends State<MonedaPage> {
  final BinanceService _binanceService = BinanceService();
  List<FlSpot> spots = [];
  String selectedInterval = "1h";

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    print("Fetching data for interval: $selectedInterval");
    Map<String, dynamic> result;
    switch (selectedInterval) {
      case "1h":
        result = await _binanceService.get1HourKlines(widget.symbol);
        break;
      case "1d":
        result = await _binanceService.get1DayKlines(widget.symbol);
        break;
      case "1s":
        result = await _binanceService.get1WeekKlines(widget.symbol);
        break;
      case "1M":
        result = await _binanceService.get1MonthKlines(widget.symbol);
        break;
      case "1a":
        result = await _binanceService.get1YearKlines(widget.symbol);
        break;
      default:
        result = {'data': [], 'success': false, 'error': 'Intervalo no válido'};
    }

setState(() {
  if (result['success'] == true) {
    List<dynamic>? data = result['data'];
    if (data != null && data.isNotEmpty) {
      print("Data loaded: ${data.length} items");

      spots=data.map((e) => FlSpot(data.indexOf(e).toDouble(), double.parse(e[4]))).toList();

      print("Data mapped to spots: ${spots.length} spots");
    } else {
      print("aqui");
      spots = [];
    }
  } else {
    // Manejar el caso de error, por ejemplo, mostrar un mensaje al usuario
    print("Error al cargar datos: ${result['error']}");
    spots = [];
  }
});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.monedaNombre),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Lógica para notificaciones
            },
          ),
          IconButton(
            icon: Icon(Icons.local_fire_department, color: Colors.black),
            onPressed: () {
              // Lógica para acciones específicas
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GraficoWidget(spots: spots), // Asegúrate de que GraficoWidget tenga un tamaño que pueda expandirse
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedInterval = "1h";
                      _fetchData();
                    });
                  },
                  child: Text("1H"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedInterval = "1d";
                      _fetchData();
                    });
                  },
                  child: Text("1D"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedInterval = "1s";
                      _fetchData();
                    });
                  },
                  child: Text("S"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedInterval = "1M";
                      _fetchData();
                    });
                  },
                  child: Text("M"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedInterval = "1a";
                      _fetchData();
                    });
                  },
                  child: Text("A"),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(widget.monedaNombre, style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            Row(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // Lógica para convertir
                  },
                  child: Text('Convertir', style: TextStyle(color: Colors.black)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                  ),
                ),
                SizedBox(width: 10), // Espacio entre botones
                TextButton(
                  onPressed: () {
                    // Lógica para comprar
                  },
                  child: Text('Comprar', style: TextStyle(color: Colors.black)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
