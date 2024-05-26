import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/views/home/modal/loot_free_manager.dart';
import 'dart:async';

class DescubrirModal extends StatefulWidget {
  @override
  State<DescubrirModal> createState() => _DescubrirModalState();
}

class _DescubrirModalState extends State<DescubrirModal> {
  late bool lootFreeAvailable;
  late Duration timeUntilNextLoot;
  late Timer timer;
  final LootFreeManager lootFreeManager = LootFreeManager({
    'loot1': LootConfig(hours: 2, minutes: 38), // Configurar tiempo de loot1
    'loot2': LootConfig(hours: 20, minutes: 0), // Configurar tiempo de loot2
  });

  @override
  void initState() {
    super.initState();
    lootFreeAvailable = lootFreeManager.isLootFreeAvailable();
    timeUntilNextLoot = lootFreeManager.timeUntilNextLoot(
        lootFreeAvailable ? 'loot1' : 'loot2'); // Inicializar timeUntilNextLoot

    // Configurar temporizador para actualizar el tiempo cada segundo
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        lootFreeAvailable = lootFreeManager.isLootFreeAvailable();
        timeUntilNextLoot = lootFreeManager
            .timeUntilNextLoot(lootFreeAvailable ? 'loot1' : 'loot2');
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancelar el temporizador al eliminar el estado del widget
    super.dispose();
  }

  void handleLootFreeTap() {
    // Manejar el toque en el botón de lootFree
    if (lootFreeAvailable) {
      // Abrir el lootFree
      Navigator.pushNamed(context, '/LootFree');
    } else {
      // Mostrar mensaje si el lootFree no está disponible
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El loot Free no está disponible en este momento.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double buttomNavBarWidth = MediaQuery.of(context).size.width;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.4,
      minChildSize: 0.32,
      maxChildSize: 0.9,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: SizedBox(
          width: buttomNavBarWidth,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 10,
                child: Container(
                  width: 60,
                  height: 7,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 164, 164, 164),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(top: 15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: SvgPicture.asset(
                            'assets/images/box.svg',
                            height: 22,
                            width: 23,
                          ),
                          title: const Text('Loot'),
                          trailing: const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              '1.280 CLP',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/Loot');
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                            leading: SvgPicture.asset(
                              'assets/images/gift_box.svg',
                              height: 22,
                              width: 23,
                            ),
                            title: const Text('Loot Free'),
                            trailing: lootFreeAvailable
                                ? const Text('Disponible',
                                    style: TextStyle(color: Colors.green))
                                : Text(
                                    'Próximo en: ${timeUntilNextLoot.inHours}:${(timeUntilNextLoot.inMinutes % 60).toString().padLeft(2, '0')}:${(timeUntilNextLoot.inSeconds % 60).toString().padLeft(2, '0')}',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                            onTap: handleLootFreeTap),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
