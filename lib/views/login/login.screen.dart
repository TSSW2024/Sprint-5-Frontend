import 'package:ejemplo_1/widgets/social.login.dart';
import 'package:ejemplo_1/widgets/text.form.global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth.viewmodel.dart';
import '../../widgets/elevated_button.widget.dart';
import '../../widgets/loading.widget.dart';
//// import '../../widgets/text_field.widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Limpia los controladores al eliminar el widget
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Consume el authViewModel
    final authViewModel = Provider.of<AuthViewModel>(context);

    // Si el usuario ya está autenticado, navegar a /home
    if (authViewModel.isAuthenticated) {
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/home'));
    }

    // Mostrar el LoadingWidget si está cargando
    if (authViewModel.isLoading) {
      return const Scaffold(
        body: Center(
          child: LoadingWidget(), // Usar el LoadingWidget aquí
        ),
      );
    }

    // Programar la muestra del SnackBar después de la construcción del widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authViewModel.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authViewModel.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
        // Limpia el mensaje de error después de mostrar el SnackBar
        authViewModel.clearErrorMessage();
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Logo',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                const Text(
                  'Inicia sesión con tu cuenta',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),

                //// Email input
                TextFormGlobal(
                  controller: _emailController,
                  text: 'Email',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),

                //// Password Input
                TextFormGlobal(
                  controller: _passwordController,
                  text: 'Password',
                  obscure: true,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 10),

                CustomElevatedButton(
                  icon: Icons.login,
                  text: 'Iniciar sesión',
                  onPressed: () {
                    authViewModel.login(
                      _emailController.text,
                      _passwordController.text,
                    );
                  },
                ),
                const SizedBox(height: 25),

                const SocialLogin(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text(
                '¿No tienes cuenta? Regístrate aquí',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
