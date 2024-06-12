import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import '../home/saldo/saldo.dart';
import '../cartera/recomendaciones_ad.dart'; // muestra un anuncio en pantalla @moizefal4
import '../../viewmodels/profile.viewmodel.dart';
import '../cartera/moneda.dart';

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
    var saldototal = profileViewModel.profile.saldototal;

    List<Color> pieColors = [
      Colors.orange,
      Colors.grey,
      Colors.blue,
    ];

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
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
                              child: PieChart(
                                dataMap: dataMap,
                                colorList: pieColors,
                                animationDuration:
                                    const Duration(milliseconds: 800),
                              ))))
                  : const Text('No tiene saldo'),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Lista de monedas:',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dataMap.length,
                itemBuilder: (context, index) {
                  String key = dataMap.keys.elementAt(index);
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage(profileViewModel.iconMap[key]!),
                        radius: 30,
                      ),
                      title: Text(key),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MonedaPage(
                                monedaNombre: key,
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 23, 206, 54)),
                        ),
                        child: const Text("Vender", style: TextStyle(color: Colors.white, fontSize: 13.9)),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
