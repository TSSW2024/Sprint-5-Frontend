import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';


class Item {
  final String name;
  final double chance;
  final String imageUrl;

  Item({required this.name, required this.chance, required this.imageUrl});
}

class CryptoLootBox extends StatefulWidget {
  @override
  _CryptoLootBoxState createState() => _CryptoLootBoxState();
}

class _CryptoLootBoxState extends State<CryptoLootBox> {
  final List<Item> items = [
    Item(chance: 0.1, name: 'Bitcoin', imageUrl: 'assets/images/bitcoin.png'),
    Item(chance: 0.2, name: 'Ethereum', imageUrl: 'assets/images/etherum.png'),
    Item(chance: 0.3, name: 'Litecoin', imageUrl: 'assets/images/litecoin.png'),
    Item(chance: 0.1, name: 'Tether', imageUrl: 'assets/images/tether.png'),
    Item(
        chance: 0.1,
        name: 'Binance Coin',
        imageUrl: 'assets/images/binance.png'),
    Item(chance: 0.1, name: 'Ripple', imageUrl: 'assets/images/ripple.png'),
    Item(chance: 0.05, name: 'Cardano', imageUrl: 'assets/images/cardano.png'),
    Item(
        chance: 0.05, name: 'Dogecoin', imageUrl: 'assets/images/dogecoin.png'),
  ];

  Item? selectedItem;
  CarouselController buttonCarouselController = CarouselController();
  bool isSpinning = false;

  Item getRandomItem() {
    final totalWeight = items.fold(0.0, (sum, item) => sum + item.chance);
    final randomNum = Random().nextDouble() * totalWeight;

    double cumulativeChance = 0;
    for (final item in items) {
      cumulativeChance += item.chance;
      if (randomNum < cumulativeChance) {
        return item;
      }
    }
    throw Exception('Should not reach here');
  }

  void spinWheel() {
    final item = getRandomItem();
    setState(() {
      selectedItem = null; // Hide the result while spinning
      isSpinning = true;
    });

    // Simulate the spinning effect by moving the carousel
    final itemIndex = items.indexOf(item);
    final randomCycles =
        Random().nextInt(5) + 5; // Random cycles between 5 and 10
    final finalIndex = itemIndex + randomCycles * items.length;

    buttonCarouselController
        .animateToPage(
      finalIndex,
      duration: const Duration(seconds: 5),
      curve: Curves.easeOut,
    )
        .then((_) {
      setState(() {
        selectedItem = item; // Show the result after spinning
        isSpinning = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
       Row(
         children: [
           const Spacer(flex: 2,), // Pushes the text to the center
            const Text(
              'Loot',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              
            ),
           const Spacer(), // Pushes the button to the right
           Padding(
             padding: const EdgeInsets.only(right: 32),
             child: IconButton(
               icon: const Icon(Icons.info),
               onPressed: () {
                 showDialog(
                   context: context,
                   builder: (context) {
                     return AlertDialog(
                       title: const Text('Lista de CriptoMonedas'),
                       content: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: items
                             .map((item) => ListTile(
                                  leading: Image.asset(
                                    item.imageUrl,
                                    height: 50, // Adjust the height as desired
                                  ),
                                   title: Text(item.name),
                                   trailing: Text('${item.chance * 100}%'),
                                 ))
                             .toList(),
                       ),
                       actions: [
                         TextButton(
                           onPressed: () {
                             Navigator.of(context).pop();
                           },
                           child: const Text('Cerrar'),
                         ),
                       ],
                     );
                   },
                 );
               },
             ),
           ),
         ],
       ),
        
        const SizedBox(height: 40),
        CarouselSlider(
          items: items.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Image.asset(item.imageUrl, fit: BoxFit.cover);
              },
            );
          }).toList(),
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            height: 150.0, // Reduced height of the carousel
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: false,
            enlargeCenterPage: true,
            viewportFraction: 0.5,
            scrollPhysics: const NeverScrollableScrollPhysics(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: isSpinning ? null : spinWheel,
          child: const Text('Girar Ruleta'),
        ),
        if (selectedItem != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '¡Ganaste ${selectedItem!.name}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
