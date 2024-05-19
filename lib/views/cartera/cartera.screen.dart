import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import '../home/saldo/saldo.dart';
import '../cartera/recomendaciones_ad.dart'; // muestra un anuncio en pantalla @moizefal4
import '../../viewmodels/profile.viewmodel.dart';

class CarteraScreen extends StatefulWidget {
  const CarteraScreen({super.key});

  @override
  State<CarteraScreen> createState() => _CarteraScreenState();
}

class _CarteraScreenState extends State<CarteraScreen> {
  @override
  Widget build(BuildContext context) {
    var profileViewModel = Provider.of<ProfileViewModel>(context);
    var dataMap = profileViewModel.profile.monedas;
    var saldototal  = profileViewModel.profile.saldototal;

    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnuncioWidget(
            titulo: anuncioSeleccionado['titulo']!,
            subtitulo: anuncioSeleccionado['subtitulo']!,
            imagenUrl: anuncioSeleccionado['icono']!,
            url: anuncioSeleccionado['url']!,
            ), // @moizefal4
            SaldoWidget(saldo: saldototal), 
            dataMap.isNotEmpty 
              ? Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                  height: 200, 
                  width: 300, 
                  child: PieChart(dataMap: dataMap),
                  )
                  )
                )
              : const Text('No tiene saldo'),
          ],
        ),
      ),
    );
  }
}