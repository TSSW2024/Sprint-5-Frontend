import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

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
        brightness: Brightness.dark,
        primaryColor: Colors.amber[800]!,
        colorScheme: const ColorScheme.dark().copyWith(
          secondary: Colors.amberAccent[400]!,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key, Key? customKey});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
        _dobController.text =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString()}';
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  SvgPicture.asset('assets/images/LogoP.svg',
                      height: 80), // Asegúrate de tener el logo en assets
                  const SizedBox(height: 20),
                  Text(
                    'Te damos la bienvenida a Utem Trades',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _usernameController,
              maxLength: 15, // Limites el número de caracteres de usuario
              decoration: const InputDecoration(
                labelText: 'Nombre de usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirmar contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _dobController,
              decoration: const InputDecoration(
                labelText: 'Fecha de nacimiento (dd/mm/yyyy)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(
                    10), // Limita la longitud a 10 caracteres (incluidas las barras)
                FilteringTextInputFormatter.digitsOnly,
                DateInputFormatter(), // Aplica el formateador personalizado
              ],
            ),
            const SizedBox(height: 20),
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
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Términos y Condiciones'),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                          content: const SingleChildScrollView(
                            child: Text(
                              '''Términos y Condiciones para UtemTX

Al hacer clic en el botón "Registrarse", usted acepta los siguientes términos y condiciones:

1. Exactitud de la Información
   - Usted es responsable de la precisión de la información proporcionada durante el registro y en cualquier momento posterior. Toda la información debe ser veraz y estar actualizada.

2. Uso de Información Personal
   - Su información personal se utilizará de acuerdo con nuestra Política de Privacidad. No compartiremos su información con terceros sin su consentimiento previo, salvo cuando lo exija la ley.

3. Seguridad de la Cuenta
   - Usted es responsable de mantener la seguridad de su cuenta, incluyendo la protección de su contraseña y cualquier otra información de acceso. Notifique inmediatamente a UtemTX si sospecha de cualquier actividad no autorizada en su cuenta.

4. Responsabilidad de Uso
   - Usted se compromete a utilizar la plataforma de manera legal y ética. Cualquier uso indebido, como actividades fraudulentas o ilícitas, resultará en la suspensión o terminación de su cuenta.

5. Cumplimiento Legal
   - Usted debe cumplir con todas las leyes y regulaciones aplicables en su jurisdicción al usar nuestra plataforma. Es su responsabilidad asegurarse de que su uso de los servicios de UtemTX sea legal en su país.

6. Modificaciones
   - UtemTX puede modificar estos términos y condiciones en cualquier momento. Le notificaremos de cualquier cambio a través de nuestra plataforma o por correo electrónico. Su uso continuado de la plataforma después de dichos cambios constituirá su aceptación de los nuevos términos.

7. Limitación de Responsabilidad
   - UtemTX no será responsable por cualquier pérdida o daño que resulte del uso de nuestra plataforma, incluidos pero no limitados a pérdidas financieras, daños indirectos o cualquier otra pérdida resultante de la negligencia o incumplimiento por parte del usuario.

8. Terminación de Servicio
   - UtemTX se reserva el derecho de suspender o terminar su acceso a la plataforma en cualquier momento y por cualquier motivo, sin previo aviso.

9. Transacciones Financieras
   - Al utilizar UtemTX, usted puede realizar transacciones financieras que incluyen la compra, venta, intercambio o almacenamiento de criptomonedas. UtemTX no garantiza la precisión de los precios ni la ejecución inmediata de las órdenes. Todas las transacciones son finales y no reembolsables.

10. Riesgos Asociados
    - Usted entiende y acepta que la compra, venta y el comercio de criptomonedas conllevan riesgos significativos. Las criptomonedas son volátiles y pueden experimentar fluctuaciones de precio importantes. Usted es responsable de todas las pérdidas resultantes de sus actividades de inversión y comercio.

11. Comisiones y Tarifas
    - UtemTX puede cobrar comisiones y tarifas por el uso de sus servicios. Estas tarifas pueden variar según el tipo de transacción y se detallarán en nuestra plataforma. Usted acepta pagar todas las tarifas aplicables.

12. No Asesoramiento Financiero
    - UtemTX no ofrece asesoramiento financiero, legal o de inversión. Toda la información proporcionada en la plataforma es solo para fines informativos. Usted debe realizar su propia investigación y consultar con asesores financieros antes de tomar decisiones de inversión.

13. Cumplimiento de AML/KYC
    - Para cumplir con las leyes y regulaciones de prevención de lavado de dinero (AML) y de conocimiento del cliente (KYC), UtemTX puede solicitar información adicional para verificar su identidad y la fuente de sus fondos. Usted se compromete a proporcionar información precisa y completa cuando sea solicitada.

14. Sin Seguro
    - No somos un banco u otra institución depositaria. Su cuenta

15. Resolución de Disputas
    - Esperamos evitar disputas, pero si hay una disputa, usted está obligado a arbitrar disputas con nosotros y la forma en que puede buscar reparación puede ser limitada.

Gracias por elegir UtemTX.
                              ''',
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _acceptedTerms
                    ? () {
                        final username = _usernameController.text;
                        final password = _passwordController.text;
                        final email = _emailController.text;
                        final dob = _selectedDate != null
                            ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                            : '';
                        // Manejar la lógica de registro aquí
                      }
                    : null,
                child: const Text('Siguiente'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[800],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    // Si la selección baseOffset es 0, no se hace ningún formato
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    var nonZeroIndex = 0;

    for (var i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      nonZeroIndex++;

      // Inserta barras diagonales en las posiciones adecuadas
      if (nonZeroIndex == 2 || nonZeroIndex == 4) {
        if (text[i] != '/') {
          buffer.write('/');
        }
      }
    }

    var formattedText = buffer.toString();

    // Si se excede la longitud de 10 caracteres, devuelve el valor antiguo
    if (formattedText.length > 10) {
      return oldValue;
    }

    // Devuelve el nuevo valor formateado con la selección al final
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
