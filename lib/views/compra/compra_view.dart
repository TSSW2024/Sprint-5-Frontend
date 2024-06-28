import 'package:flutter/material.dart';
import '../../widgets/numeric_keyboard.dart';
import '../../widgets/quick_buttons.dart';

class CompraView extends StatefulWidget {
  @override
  _CompraViewState createState() => _CompraViewState();
}

class _CompraViewState extends State<CompraView> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String moneda = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Compra de $moneda'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPriceBar(),
            SizedBox(height: 20),
            QuickButtons(
              controller: _controller,
            ),
            SizedBox(height: 20),
            NumericKeyboard(
              controller: _controller,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Quiero pagar'),
            ElevatedButton(
              onPressed: () {
                // Lógica para "Por monto"
              },
              child: Text('Por monto'),
            ),
          ],
        ),
        SizedBox(height: 8),
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Ingresar la cantidad',
            suffixText: 'CLP',
          ),
          onChanged: (value) {
            // Validación numérica
            if (!RegExp(r'^\d+$').hasMatch(value)) {
              _controller.text = value.replaceAll(RegExp(r'[^\d]'), '');
              _controller.selection = TextSelection.fromPosition(
                TextPosition(offset: _controller.text.length),
              );
            }
          },
        ),
      ],
    );
  }
}
