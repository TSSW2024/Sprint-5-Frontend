// text_field.widget.dart
// @author moisesnks
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isHidden;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.isHidden = false,
  });

  @override
  Widget build(BuildContext context) {
    // Si isHidden es true, no mostrar el campo de texto
    if (isHidden) {
      return const SizedBox.shrink(); // Devuelve un widget vacío
    }

    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 8.0), // Espacio vertical entre campos
      decoration: BoxDecoration(
        color: Colors.grey[200], // Color de fondo del contenedor
        borderRadius: BorderRadius.circular(12), // Bordes redondeados
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border:
              InputBorder.none, // Sin borde para usar el borde del contenedor
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          prefixIcon: prefixIcon, // Icono al inicio del campo
          suffixIcon: suffixIcon, // Icono al final del campo
        ),
      ),
    );
  }
}
