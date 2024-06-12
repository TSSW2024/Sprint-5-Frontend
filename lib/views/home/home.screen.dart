import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth.viewmodel.dart';
import '../mercado/mercado.screen.dart';
import '../cartera/cartera.screen.dart';
import '../profile/profile.screen.dart';
import '../home/modal/modal.dart';
import '../compra/compra_view.dart';
import '../convertir/convertir_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  DateTime lastLootFreeAccess = DateTime.now();

  // Define una lista de mapas para los elementos del BottomNavigationBar
  final List<Map<String, dynamic>> _bottomNavItems = [
    {
      'icon': Icons.bar_chart,
      'label': 'Mercado',
      'screen': const MercadoScreen(),
    },
    {
      'icon': AssetImage('assets/images/logotrades.png'),
      'label': 'UtemTX',
      'screen': null, // No asignar una pantalla a "Descubrir"
    },
    {
      'icon': Icons.account_balance_wallet,
      'label': 'Cartera',
      'screen': const CarteraScreen(),
    },
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return DescubrirModal();
        },
      );
    } else if (index == 3) {
      // Verifica si el índice es el de compra
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CompraView()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
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
        children: _bottomNavItems
            .where((item) => item['screen'] != null)
            .map((item) => item['screen'] as Widget)
            .toList(),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
        child: BottomNavigationBar(
          items: _bottomNavItems.map((item) {
            return BottomNavigationBarItem(
              icon: item['icon'] is IconData
                  ? Icon(item['icon'])
                  : Image(image: item['icon'] as AssetImage, width: 40),
              label: item['label'],
            );
          }).toList(),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: const Color.fromARGB(255, 7, 94, 177),
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
