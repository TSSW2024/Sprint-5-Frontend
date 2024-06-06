import 'package:flutter/material.dart';

class MonedaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moneda'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Add your logic here
            },
          ),
          IconButton(
            icon: Icon(Icons.local_fire_department, color: Colors.black),
            onPressed: () {
              // Add your logic here
            },
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Text('Contenido de la página Moneda'),
        ),
      ),
    );
  }
}