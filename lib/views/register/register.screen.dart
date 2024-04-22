import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, Key? customKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
          accentColor: Colors.orange,
        ).copyWith(secondary: Colors.orange),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key, Key? customKey});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _docController = TextEditingController();
  DateTime? _selectedDate;
  bool _acceptedTerms = false;
  bool _showTermsOverlay = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _toggleTermsOverlay() {
    setState(() {
      _showTermsOverlay = !_showTermsOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de usuario',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () => _selectDate(context),
              child: Text(
                _selectedDate == null
                    ? 'Seleccionar fecha de nacimiento'
                    : 'Fecha de nacimiento: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              ),
            ),
            TextField(
              controller: _docController,
              decoration: const InputDecoration(
                labelText: 'Documento',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: _acceptedTerms,
                  onChanged: (value) {
                    setState(() {
                      _acceptedTerms = value!;
                    });
                  },
                ),
                const Text('Aceptar términos y condiciones'),
                IconButton(
                  icon: const Icon(Icons.info),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Términos y Condiciones'),
                          content: const SingleChildScrollView(
                            child: Text(
                              'Al hacer clic en el botón "Registrarse", acepta los siguientes términos y condiciones:\n\n- Usted es responsable de la precisión de la información proporcionada.\n- Su información personal se utilizará de acuerdo con nuestra política de privacidad.\n- No compartiremos su información personal con terceros sin su consentimiento.\n- Usted es responsable de mantener la seguridad de su cuenta.',
                            ),
                          ),
                          actions: <Widget>[
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
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _acceptedTerms
                  ? () {
                      final username = _usernameController.text;
                      final password = _passwordController.text;
                      final email = _emailController.text;
                      final dob = _selectedDate != null
                          ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                          : '';
                      final doc = _docController.text;      
                      if (kDebugMode) {
                        print(
                          'Usuario: $username\nContraseña: $password\nCorreo: $email\nFecha de nacimiento: $dob\n Documento: $doc\n',
                        );
                      }
                    }
                  : null,
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
      floatingActionButton: _showTermsOverlay
          ? FloatingActionButton(
              onPressed: _toggleTermsOverlay,
              child: const Icon(Icons.close),
            )
          : null,
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _docController.dispose();
    super.dispose();
  }
}



