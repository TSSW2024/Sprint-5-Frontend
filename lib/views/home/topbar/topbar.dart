import 'package:ejemplo_1/views/home/topbar/buscar_monedas.dart';
import 'package:flutter/material.dart';
import 'package:ejemplo_1/views/home/topbar/ajustes.dart';
import 'package:ejemplo_1/views/home/topbar/nosotros.dart';
void main() =>runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Home",
      home: Inicio(),
    );
  }
}
class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 20, 23, 56),
      leading:IconButton(
              icon: const ImageIcon(
                AssetImage('assets/arcticons_money-manager.png'),
                color: Colors.white,
                size: 36,
              ),
              onPressed: () {
                // acción del botón del icono
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Ajustes()));
              },
            ),
          actions: [
            
            const SizedBox(width: 50),
            IconButton(
              icon: const Icon(Icons.search, size: 36),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const Buscarmonedas()));
              },
            ),
           const SizedBox(width: 50),
            IconButton(
              icon: const ImageIcon(
                 AssetImage('assets/grupo.png'),
                size: 36,
              ),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>const Acercadenosotros()));
              },
            ),
          ],
        ),
      );
    
  }
}
  
