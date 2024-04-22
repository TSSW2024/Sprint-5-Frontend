import 'package:flutter/material.dart';
import 'mockup_recomendaciones.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

final Map<String, String> anuncioSeleccionado =
    seleccionarAnuncioAleatorio(datosAnuncios);

Map<String, String> seleccionarAnuncioAleatorio(
    List<Map<String, String>> datosAnuncios) {
  final random = Random();
  final index = random.nextInt(datosAnuncios.length);
  return datosAnuncios[index];
}

void _launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

class AnuncioWidget extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final String
      imagenUrl; // Cambiado de IconData a String para la URL de la imagen
  final String url;

  const AnuncioWidget({
    super.key, // Añadí 'Key?' para corregir el error de compilación
    required this.titulo,
    required this.subtitulo,
    required this.imagenUrl,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Image.network(
                  imagenUrl), // Cambiado a Image.network para cargar la imagen desde una URL
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    subtitulo,
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
