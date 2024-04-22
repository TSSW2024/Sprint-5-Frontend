// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../home/saldo/saldo.dart';
import '../cartera/recomendaciones_ad.dart'; // muestra un anuncio en pantalla @moizefal4

class CarteraScreen extends StatelessWidget {
  const CarteraScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartera page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SaldoWidget(saldo: 1000.0),
            // ignore: prefer_const_constructors
            Text('Cartera page'),
            AnuncioWidget(
              titulo: anuncioSeleccionado['titulo']!,
              subtitulo: anuncioSeleccionado['subtitulo']!,
              imagenUrl: anuncioSeleccionado['icono']!,
              url: anuncioSeleccionado['url']!,
            ), // @moizefal4
          ],
        ),
      ),
    );
  }
}
