import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction {
  final String description;
  final String amount;
  final String network;
  final String date;
  final String time;

  Transaction({
    required this.description,
    required this.amount,
    required this.network,
    required this.date,
    required this.time,
  });
}

List<Transaction> transactions = [
  Transaction(
    description: 'Interacción de contratos',
    amount: '+3 WLD',
    network: 'Optimism',
    date: '25/6',
    time: '17:12',
  ),
  Transaction(
    description: 'Interacción de contratos',
    amount: '+200 WGC',
    network: 'Base',
    date: '16/6',
    time: '18:14',
  ),
  Transaction(
    description: 'Recibir',
    amount: '+70,4377 USDT',
    network: 'Ethereum',
    date: '13/6',
    time: '15:04',
  ),
  Transaction(
    description: 'Recibir',
    amount: '+100 DAI',
    network: 'Fantom',
    date: '11/6',
    time: '12:51',
  ),
  Transaction(
    description: 'Enviar',
    amount: '-13,62 USDC.e',
    network: 'Optimism',
    date: '31/5',
    time: '05:42',
  ),
  Transaction(
    description: 'Recibir',
    amount: '+0,00009999 ETH',
    network: 'Ethereum',
    date: '31/5',
    time: '05:41',
  ),
  Transaction(
    description: 'Swap cross-chain',
    amount: '+0,09953 OP ETH',
    network: 'OKX Web3',
    date: '31/5',
    time: '05:40',
  ),
  Transaction(
    description: 'Interacción de contratos',
    amount: '+161,8 FINU',
    network: 'Flare',
    date: '30/5',
    time: '14:57',
  ),
];

class _tablaHistorial extends StatefulWidget {
  const _tablaHistorial({Key? key}) : super(key: key);

  @override
  State<_tablaHistorial> createState() => _tablaHistorialState();
}

class _tablaHistorialState extends State<_tablaHistorial> {
  DateTimeRange? dateRange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.date_range),
                onPressed: () async {
                  DateTimeRange? picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2009, 1, 1),
                    lastDate: DateTime(2024, 6, 27),
                    initialDateRange: dateRange,
                  );
                  if (picked != null && picked != dateRange) {
                    setState(() {
                      dateRange = picked;
                    });
                  }
                },
              ),
              if (dateRange != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${DateFormat('dd/MM/yyyy').format(dateRange!.start)}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.arrow_forward, size: 20,),
                      SizedBox(width: 10,),
                      Text(
                        '${DateFormat('dd/MM/yyyy').format(dateRange!.end)}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Row(
                    children: [
                      Container(
                        width: 150,
                        child: Text('Transacción',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.grey)),
                      ),
                      Container(
                        width: 150,
                        child: Text('Cantidad',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.grey),
                            textAlign: TextAlign.left),
                      ),
                      Container(
                        width: 100,
                        child: Text('Moneda',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.grey)),
                      ),
                      Container(
                        width: 132, // Ajusta el ancho según sea necesario
                        child: Text('Fecha',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.grey),
                            textAlign: TextAlign.right),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 550, // Ajusta el ancho según sea necesario
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      return TransactionRow(transaction: transactions[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TransactionRow extends StatelessWidget {
  final Transaction transaction;

  TransactionRow({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final color_valor =
        transaction.amount.contains('+') ? Colors.green : Colors.black;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 150,
            child: Text(transaction.description,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                )),
          ),
          Container(
            width: 150,
            child: Text(transaction.amount,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: color_valor, fontWeight: FontWeight.w500)),
          ),
          Container(
            width: 100,
            child: Text(
              transaction.network,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            width: 134,
            child: Text('${transaction.date}, ${transaction.time}',
                textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}

class historial_transacciones extends StatefulWidget {
  const historial_transacciones({Key? key}) : super(key: key);

  @override
  _historial_transaccionesState createState() => _historial_transaccionesState();
}

class _historial_transaccionesState extends State<historial_transacciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de transacciones'),
      ),
      body: const _tablaHistorial(),
    );
  }
}
