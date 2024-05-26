import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth.viewmodel.dart';
import '../descubrir/descubrir.screen.dart';
import '../mercado/mercado.screen.dart';
import '../cartera/cartera.screen.dart';
import '../profile/profile.screen.dart';
import '../profile/profile.screen.dart'; // se arreglo problema linea 71


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

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

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    // Si el usuario no está autenticado, navega a /login
    if (!authViewModel.isAuthenticated) {
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/login'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Utem Trading'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Aquí puedes manejar la acción cuando se presiona el botón.
              // Por ejemplo, puedes navegar a la pantalla de perfil.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
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
              // _showDescubrirModal(context);
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
