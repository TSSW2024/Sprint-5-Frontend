import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth.viewmodel.dart';

import '../descubrir/descubrir.screen.dart';
import '../mercado/mercado.screen.dart';
import '../cartera/cartera.screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  // Define una lista de mapas para los elementos del BottomNavigationBar
  final List<Map<String, dynamic>> _bottomNavItems = [
    {
      'icon': Icons.bar_chart,
      'label': 'Mercado',
      'screen': const MercadoScreen(),
    },
    {
      'icon': Icons.add_circle,
      'label': 'Descubrir',
      'screen': const DescubrirScreen(),
    },
    {
      'icon': Icons.account_balance_wallet,
      'label': 'Cartera',
      'screen': const CarteraScreen(),
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _showDescubrirModal(BuildContext context) {

    double buttomNavBarWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
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
                        top: -15,
                        child: Container(
                            width: 60,
                            height: 7,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ))),
                    Column(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.shopping_cart),
                          title: const Text('Comprar'),
                          onTap: () {
                            Navigator.pushNamed(context, '/comprar');
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.sell),
                          title: const Text('Vender'),
                          onTap: () {
                            Navigator.pushNamed(context, '/vender');
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.swap_horiz),
                          title: const Text('Intercambiar'),
                          onTap: () {
                            Navigator.pushNamed(context, '/intercambiar');
                          },
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    // Si el usuario no está autenticado, navega a /login
    if (!authViewModel.isAuthenticated) {
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/login'));
    }

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children:
            _bottomNavItems.map((item) => item['screen'] as Widget).toList(),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          items: _bottomNavItems.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item['icon']),
              label: item['label'],
            );
          }).toList(),
          currentIndex: _selectedIndex,
          onTap: (index) {
            if (index == 1) {
              _showDescubrirModal(context);
              _onItemTapped(index);
            } else {
              _onItemTapped(index);
            }
          },
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
