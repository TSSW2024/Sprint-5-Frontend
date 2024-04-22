
import 'package:flutter/material.dart';
void main() =>runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title:"buscar monedas",
      home: Buscarmonedas(),
    );
  }
}
class Buscarmonedas extends StatefulWidget {
  const Buscarmonedas({super.key});

  @override
  State<Buscarmonedas> createState() => _BuscarmonedasState();
}

class _BuscarmonedasState extends State<Buscarmonedas> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:
      Center(child: Text("buscador de monedas"),),
    );
  }
}