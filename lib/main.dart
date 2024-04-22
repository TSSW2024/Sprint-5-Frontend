import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/auth.viewmodel.dart';
import 'viewmodels/profile.viewmodel.dart';

import 'views/home/home.screen.dart';
import 'views/login/login.screen.dart';
import 'views/register/register.screen.dart';
import 'views/depositar/depositar_dinero.dart';

import 'services/profile.service.dart';
import 'services/auth.service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final profileService = ProfileService();
    final authService = AuthService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel(authService)),
        ChangeNotifierProvider(create: (_) => ProfileViewModel(profileService)),
      ],
      child: MaterialApp(
        title: 'Login App',
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegistrationScreen(),
          '/home': (context) => const HomeScreen(),
          '/depositar': (context) => const DepositarDinero(),
        },
      ),
    );
  }
}
