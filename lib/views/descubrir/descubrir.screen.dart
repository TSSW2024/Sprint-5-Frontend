import 'package:flutter/material.dart';

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

class DescubrirScreen extends StatelessWidget {
  const DescubrirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final anchoActual = MediaQuery.of(context).size.width;
    final altoActual = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Descubrir page'),
      ),
      body: Center(
          child: Column(
        children: [
          DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  SizedBox(
                      width: anchoActual,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Monedas",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      )),
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
                          const Text('Top Declinerss'),
                          const Text('Nuevos'),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      )),
    );
  }

  Container listaMonedas(int index) {
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
              )),
          Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Text(
                _monedas[index]["moneda"],
                style: const TextStyle(fontSize: 20),
              )),
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
              )),
        ],
      ),
    );
  }
}
