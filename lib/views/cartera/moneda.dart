import 'package:flutter/material.dart';
import 'package:ejemplo_1/widgets/grafico_widget.dart';
import 'package:fl_chart/fl_chart.dart'; 

class MonedaPage extends StatelessWidget {
  final String monedaNombre;


  const MonedaPage({Key? key, required this.monedaNombre,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Datos estáticos para el gráfico, reemplaza esto con tus propios datos
    final List<FlSpot> spots = [
      FlSpot(1, 0),
      FlSpot(2, 1.5),
      FlSpot(3, 1),
      FlSpot(4, 1.1),
      FlSpot(5, 0.5),
       ];

    return Scaffold(
      appBar: AppBar(
        title: Text(monedaNombre),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // aaaa
            },
          ),
          IconButton(
            icon: Icon(Icons.local_fire_department, color: Colors.black),
            onPressed: () {
              // aaaa
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GraficoWidget(spots: spots), 
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
              child: Text(monedaNombre, style: TextStyle(fontSize: 20, color: Colors.white)),
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