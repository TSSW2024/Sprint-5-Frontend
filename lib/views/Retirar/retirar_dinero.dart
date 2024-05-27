import 'package:flutter/material.dart';

class RetirarDinero extends StatelessWidget {
  const RetirarDinero({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retirar Dinero'),
      ),
      body: const Center(
        child: Text('Esta es la vista para retirar dinero'),
      ),
    );
  }
}
