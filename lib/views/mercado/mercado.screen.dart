import 'package:flutter/material.dart';

class MercadoScreen extends StatelessWidget {
  const MercadoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mercado page'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Mercado page'),
          ],
        ),
      ),
    );
  }
}
