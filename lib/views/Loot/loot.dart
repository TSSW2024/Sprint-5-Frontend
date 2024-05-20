import 'package:ejemplo_1/views/Loot/drops.widget.dart';
import 'package:flutter/material.dart';
import './loot.coin.dart';

class Loot extends StatelessWidget {
  const Loot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Loot pagado'),
        ),
        body: Column(
          children: [
            DropsWidget(),
            const SizedBox(height: 50,),
             CryptoLootBox(),
          ],
        ));
  }
}
