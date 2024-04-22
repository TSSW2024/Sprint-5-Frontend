
import 'package:flutter/material.dart';

void main() =>runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title:"ajustes",
      home: Ajustes(),
    );
  }
}
class Ajustes extends StatefulWidget {
  const Ajustes({super.key});

  @override
  State<Ajustes> createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:
      Center(child: Text("Ajustes"),),
    );
  }
}