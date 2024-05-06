import 'package:flutter/material.dart';

class IntercambiarScreen extends StatelessWidget {
  const IntercambiarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('intercambiar'),
      ),
      body: const Center(
        child: Text('Esta es la vista para intercambiar monedas'),
      ),
    );
  }
}
