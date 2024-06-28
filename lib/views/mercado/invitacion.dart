import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';

class InvitacionScreen extends StatefulWidget {
  @override
  _InvitacionScreenState createState() => _InvitacionScreenState();
}

class _InvitacionScreenState extends State<InvitacionScreen> {
  late Timer _timer;
  Duration _duration = Duration(hours: 1); // Ejemplo de duración de 1 hora

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_duration.inSeconds == 0) {
        _timer.cancel();
      } else {
        setState(() {
          _duration = _duration - Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double referidosUsadosPorcentaje = 0.5; // Ejemplo de porcentaje usado
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
             padding: const EdgeInsets.symmetric(horizontal: 20), // Ajusta el padding según sea necesario
                  child: RichText(
                    textAlign: TextAlign.center, // Centra el texto
                    text: const TextSpan(
                      text: '¡¡Invita a tus amigos para reclamar este premio!!',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        height: 1.5, // Ajusta el espacio entre líneas si es necesario
                      ),
                    ),
                  ),
                ),
            const Text(
              'Invitaciones enviadas: 0', // Reemplaza 0 con la variable que maneja el contador
              style: TextStyle(
                fontSize: 18, // Tamaño del texto para el contador
                color: Colors.black, // Asume que quieres un color de texto estándar
              ),
            ),
            Container(
              width: 200,
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(touchCallback: (FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
                          // Opcional: Añade acciones al tocar las secciones del gráfico
                        }),
                        borderData: FlBorderData(
                          show: false, 
                        ),
                        sectionsSpace: 2, 
                        centerSpaceRadius: 100, 
                        sections: [
                          PieChartSectionData(
                            color: Color(0xFF87CEEB), 
                            value: referidosUsadosPorcentaje * 100,
                            title: '${(referidosUsadosPorcentaje * 100).toStringAsFixed(0)}%',
                            radius: 30,
                            titleStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                            ),
                            badgePositionPercentageOffset: .98,
                          ),
                          PieChartSectionData(
                            color: Color(0xFFB0C4DE), 
                            value: (1 - referidosUsadosPorcentaje) * 100,
                            title: '',
                            radius: 25,
                          ),
                        ],
                      ),
                      swapAnimationDuration: Duration(milliseconds: 150), // Duración de la animación
                      swapAnimationCurve: Curves.linear, // Tipo de animación
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción para invitar amigos
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xFF87CEFA),
              ),
              child: Text('Invitar Amigos'),
            ),
            SizedBox(height: 20),
            Text(
              'Próximo en: ${_duration.inHours}:${(_duration.inMinutes % 60).toString().padLeft(2, '0')}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF00008B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}