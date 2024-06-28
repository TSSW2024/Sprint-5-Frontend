import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'cripto_search.dart';
import 'seguimiento.dart';
import 'package:flutter_svg/svg.dart';
import 'cripto_search.dart';
import 'invitacion.dart';


final List _monedas = [
  {
    "moneda": "BTC",
    "value": 69350.08,
    "ratio": -1.0900,
    "icon": "assets/images/bitcoin.png"
  },
  {
    "moneda": "ETH",
    "value": 2350.67,
    "ratio": 0.7600,
    "icon": "assets/images/etherum.png"
  },
  {
    "moneda": "LTC",
    "value": 182.54,
    "ratio": 2.1500,
    "icon": "assets/images/litecoin.png"
  },
];

class MercadoScreen extends StatelessWidget {
  const MercadoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final altoActual = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2, // Dos tabs: Mercado y Seguimiento
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBar(
                bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text("Mercado", style: TextStyle(fontSize: 20)),
                ),
                Tab(child: Text("Seguimiento", style: TextStyle(fontSize: 20))),
              ],
            ))),
        body: const TabBarView(
          children: [
            MercadoTab(),
            SeguimientoTab(),
          ],
        ),
      ),
      body: Center(
          child: Column(
        children: [
          DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text("Monedas 1.0", style: TextStyle(fontSize: 24)),
                      SizedBox(width: 10), // Espacio entre los elementos
                      Expanded(
                        child: CryptoTypeaheadWidget(),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.transparent,
                    child: TabBar(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      indicatorPadding: const EdgeInsets.all(10),
                      tabs: const [
                        Tab(
                          text: 'Top',
                        ),
                        Tab(
                          text: 'Top Decliners',
                        ),
                        Tab(text: 'Nuevos'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: altoActual * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBarView(
                        children: [
                          ListView.builder(
                              itemCount: _monedas.length,
                              itemBuilder: (context, index) {
                                return listaMonedas(index);
                              }),
                          const Text('Top Decliners'),
                          const Text('Nuevos'),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción al presionar el botón
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InvitacionScreen()),
          );
        },
        backgroundColor: Colors.yellowAccent,
        child: SvgPicture.asset(
          'assets/images/gift-svgrepo-com (2).svg',
          width: 50, // Ajusta el tamaño según sea necesario
          height: 50, // Ajusta el tamaño según sea necesario
        ), // Icono del botón
      ),
    );
  }
}

class MercadoTab extends StatelessWidget {
  const MercadoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final altoActual = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const Row(
            children: [
              Text("Monedas 1.0", style: TextStyle(fontSize: 24)),
              SizedBox(width: 10), // Espacio entre los elementos
              Expanded(
                child: CryptoTypeaheadWidget(),
              ),
            ],
          ),
          Container(
            color: Colors.transparent,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.grey, width: 2),
              ),
              indicatorPadding: const EdgeInsets.all(10),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              tabs: [
                Tab(text: 'Top'),
                Tab(text: 'Top Decliners'),
                Tab(text: 'Nuevos'),
              ],
            ),
          ),
          SizedBox(
            height: altoActual * 0.5,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: TabBarView(
                children: [
                  TopTab(),
                  Center(child: Text('Top Decliners')),
                  Center(child: Text('Nuevos')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopTab extends StatelessWidget {
  const TopTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _monedas.length,
      itemBuilder: (context, index) {
        return Container(
          height: 60,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Image.asset(
                  _monedas[index]["icon"],
                  width: 50,
                  height: 50,
                ),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Text(
                  _monedas[index]["moneda"],
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      _monedas[index]["value"].toString(),
                      style: const TextStyle(color: Colors.green),
                    ),
                    Text(_monedas[index]["ratio"].toString()),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SeguimientoTab extends StatelessWidget {
  const SeguimientoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CryptoProvider(),
      child: const TopTab(),
    );
  }
}
