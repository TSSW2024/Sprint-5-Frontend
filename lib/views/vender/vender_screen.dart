import 'package:flutter/material.dart';

class VenderScreen extends StatelessWidget {
  const VenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vender'),
      ),
      body: const Center(
        child: Text('Esta es la vista para vender monedas'),
      ),
    );
  }
}
