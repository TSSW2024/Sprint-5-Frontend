// lib/widgets/numeric_keyboard.dart
import 'package:flutter/material.dart';

class NumericKeyboard extends StatelessWidget {
  final TextEditingController controller;

  NumericKeyboard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildKeyboardRow(['1', '2', '3']),
        _buildKeyboardRow(['4', '5', '6']),
        _buildKeyboardRow(['7', '8', '9']),
        _buildKeyboardRow(['Borrar', '0', 'Limpiar']),
      ],
    );
  }

  Widget _buildKeyboardRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: keys.map((key) {
        return ElevatedButton(
          onPressed: () {
            _onKeyPressed(key);
          },
          child: Text(key),
        );
      }).toList(),
    );
  }

  void _onKeyPressed(String key) {
    if (key == 'Borrar') {
      if (controller.text.isNotEmpty) {
        controller.text =
            controller.text.substring(0, controller.text.length - 1);
      }
    } else if (key == 'Limpiar') {
      controller.clear();
    } else {
      controller.text += key;
    }
  }
}
