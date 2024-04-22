import 'package:flutter/material.dart';


void main()=>runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title:"acerca de nosotros",
      home: Acercadenosotros(),
    );
  }
}
class Acercadenosotros extends StatefulWidget {
  const Acercadenosotros({super.key});

  @override
  State<Acercadenosotros> createState() => _AcercadenosotrosState();
}

class _AcercadenosotrosState extends State<Acercadenosotros> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
            body:
      Center(child: Text("Acerca de nosotros"),),
    );
  }
}