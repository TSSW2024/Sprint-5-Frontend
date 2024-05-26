import './loot.coin.dart';
import 'package:flutter/material.dart';
import './drops.widget.dart';

class LootFree extends StatelessWidget {
  const LootFree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loot Free'),
      ),
      body:  Column(
        children: [
          DropsWidget(),
          const SizedBox(height: 50,),
          CryptoLootBox(),
        ],
      ),
    );
  }
}
