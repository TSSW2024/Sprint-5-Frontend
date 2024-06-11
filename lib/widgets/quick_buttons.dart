// lib/widgets/quick_buttons.dart
import 'package:flutter/material.dart';

class QuickButtons extends StatelessWidget {
  final TextEditingController controller;

  QuickButtons({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildQuickButton('5000'),
            _buildQuickButton('10000'),
            _buildQuickButton('20000'),
          ],
        ),
        SizedBox(height: 8),
        Text('Límite máximo: 100000 CLP'),
      ],
    );
  }

  Widget _buildQuickButton(String amount) {
    return ElevatedButton(
      onPressed: () {
        controller.text = amount;
      },
      child: Text('\$$amount'),
    );
  }
}
