
import 'package:flutter/material.dart';

import 'dart:async';
import './drops.mockup.dart';

class DropsWidget extends StatelessWidget {
  const DropsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Filtrar drops con poca probabilidad
    final List<Drops> hotDrops =
        dropsMockup.where((drop) => drop.probability < 0.1).toList();
    // Filtrar drops normales
    final List<Drops> normalDrops =
        dropsMockup.where((drop) => drop.probability >= 0.1).toList();
    final widthOfRow = MediaQuery.of(context).size.width;

    return Row(
      children: <Widget>[
        Column(
          children: [
            const Row(
              children: [
                Text('Hot Drops🔥',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
            SizedBox(
              width: widthOfRow * 0.4,
              height: 100,
              child: HotDropsView(hotDrops: hotDrops),
            ),
          ],
        ),
        Column(
          children: [
            const Row(
              children: [
                Text('Normal Drops',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
            SizedBox(
              width: widthOfRow * 0.6,
              height: 100,
              child: NormalDropsView(normalDrops: normalDrops),
              // Aquí puedes agregar la lógica para los drops normales
            ),
          ],
        ),
      ],
    );
  }
}

class NormalDropsView extends StatefulWidget {
  final List<Drops> normalDrops;

  const NormalDropsView({required this.normalDrops, super.key});

  @override
  _NormalDropsViewState createState() => _NormalDropsViewState();
}

class _NormalDropsViewState extends State<NormalDropsView> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < widget.normalDrops.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      itemCount: widget.normalDrops.length,
      itemBuilder: (context, index) {
        return NormalDrop(drop: widget.normalDrops[index]);
      },
    );
  }
}

class NormalDrop extends StatelessWidget {
  final Drops drop;

  const NormalDrop({required this.drop, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(
                width:
                    20), // Añadir un espacio entre la imagen y el texto (opcional
            Container(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              child: Image.asset(drop.iconImagePath, fit: BoxFit.contain),
            ),
            const SizedBox(width: 60),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(drop.username,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(drop.cryptoLootBox),
                Text(drop.ganancia.toString()),
                Text('${drop.probability * 100}%'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HotDropsView extends StatefulWidget {
  final List<Drops> hotDrops;

  const HotDropsView({required this.hotDrops, super.key});

  @override
  _HotDropsViewState createState() => _HotDropsViewState();
}

class _HotDropsViewState extends State<HotDropsView> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentIndex < widget.hotDrops.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: widget.hotDrops.length,
      itemBuilder: (context, index) {
        return HotDrop(drop: widget.hotDrops[index]);
      },
    );
  }
}

class HotDrop extends StatelessWidget {
  final Drops drop;

  const HotDrop({required this.drop, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Container(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              child: Image.asset(drop.iconImagePath, fit: BoxFit.contain),
            ),
            const SizedBox(width: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(drop.username,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(drop.cryptoLootBox),
                Text(drop.ganancia.toString()),
                Text('${drop.probability * 100}%'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
