import 'package:flutter/material.dart';

class ComprarScreen extends StatelessWidget {
  const ComprarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comprar'),
      ),
      body: const Center(
        child: Text('Esta es la vista para '),
      ),
    );
  }
}
