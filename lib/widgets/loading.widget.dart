// loading.widget.dart
// @author moisesnks
import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  LoadingWidgetState createState() => LoadingWidgetState();
}

class LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _emojiAnimation;
  late Animation<double> _loadingTextAnimation;

  final List<String> _emojis = ['😊', '😃', '😎', '😍', '🤔', '🤗'];
  int _currentEmojiIndex = 0;

  @override
  void initState() {
    super.initState();

    // Configurar el controlador de animación
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    // Configurar la animación del emoji
    _emojiAnimation = Tween<double>(
      begin: 0,
      end: _emojis.length.toDouble(),
    ).animate(_animationController)
      ..addListener(() {
        setState(() {
          _currentEmojiIndex = (_emojiAnimation.value).toInt() % _emojis.length;
        });
      });

    // Configurar la animación del texto "Cargando..."
    _loadingTextAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Indicador circular con emoji animado dentro
          Stack(
            alignment: Alignment.center,
            children: [
              const CircularProgressIndicator(),
              Text(
                _emojis[_currentEmojiIndex],
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Texto "Cargando..." con animación en los puntos suspensivos
          AnimatedBuilder(
            animation: _loadingTextAnimation,
            builder: (context, child) {
              const String text = 'Cargando';
              final int dots = (_loadingTextAnimation.value * 4).toInt() % 4;
              final String animatedText = '$text${'.' * dots}';

              return Text(
                animatedText,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
