// lib/views/convertir/convertir_view.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../widgets/numeric_keyboard.dart';
import '../../widgets/segmented_control.dart';

class ConvertirView extends StatefulWidget {
  @override
  _ConvertirViewState createState() => _ConvertirViewState();
}

class _ConvertirViewState extends State<ConvertirView> {
  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();
  String _selectedSegment = 'Mercado';
  String _fromCurrency = 'BTC';
  String _toCurrency = 'ETH';
  double _conversionRate = 0.065; // Tasa de conversión ficticia para BTC -> ETH

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convertir'),
      ),
      body: SingleChildScrollView(
        // Envuelve el contenido con SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SegmentedControl(
                segments: ['Mercado', 'Límite'],
                selectedSegment: _selectedSegment,
                onSegmentChanged: (String? segment) {
                  setState(() {
                    _selectedSegment = segment ?? 'Mercado';
                  });
                },
              ),
              SizedBox(height: 16),
              _buildInputFields(),
              SizedBox(height: 16),
              _buildConversionRate(),
              SizedBox(height: 16),
              NumericKeyboard(controller: _fromController),
              SizedBox(height: 16),
              _buildActionButtons(),
              SizedBox(
                  height:
                      16), // Agrega espacio adicional al final si es necesario
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildCurrencyInput(
                label: 'De',
                controller: _fromController,
                currency: _fromCurrency,
                onCurrencyChanged: (String? value) {
                  setState(() {
                    _fromCurrency = value ?? 'BTC';
                  });
                },
              ),
            ),
            SizedBox(width: 8),
            Text('Saldo: 1.234 BTC'), // Saldo ficticio
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildCurrencyInput(
                label: 'A',
                controller: _toController,
                currency: _toCurrency,
                onCurrencyChanged: (String? value) {
                  setState(() {
                    _toCurrency = value ?? 'ETH';
                  });
                },
              ),
            ),
            SizedBox(width: 8),
            Text('Saldo: 3.456 ETH'), // Saldo ficticio
          ],
        ),
      ],
    );
  }

  Widget _buildCurrencyInput(
      {String? label,
      TextEditingController? controller,
      String? currency,
      ValueChanged<String?>? onCurrencyChanged,
      String? otherCurrency}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label ?? ''),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixText: currency ?? '',
                ),
              ),
            ),
            SizedBox(width: 8),
            DropdownButton<String>(
              value: currency,
              items: ['BTC', 'ETH'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: onCurrencyChanged,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConversionRate() {
    return Text(
      'Tasa de conversión: 1 BTC = $_conversionRate ETH',
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Previous'),
        ),
        ElevatedButton(
          onPressed: () {
            // Lógica de conversión
          },
          child: Text('Convertir'),
        ),
      ],
    );
  }
}
