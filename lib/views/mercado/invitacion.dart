import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';

class InvitacionScreen extends StatefulWidget {
  @override
  _InvitacionScreenState createState() => _InvitacionScreenState();
}

class _InvitacionScreenState extends State<InvitacionScreen> {
  late Timer _timer;
  Duration _duration = Duration(days: 5); // Duración inicial de 5 días
  double referidosUsadosPorcentaje =
      0.0; // Porcentaje inicial de referidos usados
  bool _puedeRetirar = false; // Indicador para habilitar el botón de retirar
  final String userId = "209415"; // ID único de usuario
  final String appLink = "https://utemtx.web.app/"; // Enlace de invitación base

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

  void _incrementarPorcentaje() {
    setState(() {
      referidosUsadosPorcentaje += 0.1;
      if (referidosUsadosPorcentaje >= 1.0) {
        referidosUsadosPorcentaje = 1.0;
        _puedeRetirar = true;
      }
    });
  }

  void _retirar(BuildContext context) {
    if (_puedeRetirar) {
      // Lógica para retirar aquí
      // Mostrar mensaje flotante de retirado con éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Retirado con éxito!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _mostrarModalInvitacion(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Invita a tus amigos',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              QrImageView(
                data: appLink + userId,
                size: 200.0,
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 20),
              SelectableText(
                'ID de referido: $userId',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SelectableText(
                appLink + userId,
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      // Lógica para compartir en redes sociales
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      // Lógica para compartir en redes sociales
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      // Lógica para compartir en redes sociales
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¡Invita a tus amigos y gana premios!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => _retirar(context),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.width * 0.8,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  color: _puedeRetirar
                                      ? Colors.yellow
                                      : Colors.blue,
                                  value: referidosUsadosPorcentaje * 100,
                                  title:
                                      '${(referidosUsadosPorcentaje * 100).toStringAsFixed(0)}%',
                                  radius: 40,
                                  titleStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                if (referidosUsadosPorcentaje < 1.0)
                                  PieChartSectionData(
                                    color: Colors.grey.shade300,
                                    value:
                                        (1 - referidosUsadosPorcentaje) * 100,
                                    title: '',
                                    radius: 30,
                                  ),
                              ],
                              centerSpaceRadius: 100,
                            ),
                          ),
                        ),
                        if (referidosUsadosPorcentaje == 1.0)
                          Image.asset(
                            'assets/images/bitcoin.png',
                            width: 80,
                            height: 80,
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => _mostrarModalInvitacion(context),
                    icon: Icon(Icons.share),
                    label: Text('Invitar Amigos'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Tiempo restante: ${_duration.inDays} días ${_duration.inHours % 24} horas ${(_duration.inMinutes % 60)} minutos',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
