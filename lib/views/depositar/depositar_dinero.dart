import 'package:flutter/material.dart';

class DepositarDinero extends StatelessWidget {
  const DepositarDinero({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depositar Dinero'),
      ),
      body: const Center(
        child: Text('Esta es la vista para depositar dinero'),
      ),
    );
  }
}
