import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/password_reset_provider.dart';
import 'package:proyecto/screens/login_screen.dart';
import 'package:proyecto/widgets/interfaz_inicio.dart';

class PasswordResetScreen extends StatelessWidget {
  static const routeName = '/password-reset';

  PasswordResetScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passwordResetProvider = Provider.of<PasswordResetProvider>(context);
    String? _errorMessage;


    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InterfazInicio(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Reestablecer Contraseña',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color(0xFFF91659),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, right: 30.0, left: 30.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    onChanged: (email) {
                      final passwordResetProvider =
                          Provider.of<PasswordResetProvider>(context, listen: false);
                      if (!passwordResetProvider.validateEmail(email)) {
                        // El correo electrónico no es válido, puedes mostrar un mensaje de error o deshabilitar el botón.
                        print('Correo electrónico no válido');
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Ingrese correo electrónico',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        final email = _emailController.text;
                        if (email.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Por favor, ingrese un correo electrónico.'),
                            ),
                          );
                        }
                        await passwordResetProvider.resetPassword(email);
                        final resetError = passwordResetProvider.resetError;
                        if (resetError == null) {
                          // Restablecimiento de contraseña exitoso
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Se ha enviado un correo de restablecimiento de contraseña.'),
                            ),
                          );
                        } else {
                          // Error en el restablecimiento de contraseña
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Error al restablecer la contraseña: $resetError'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          print(resetError);
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Reestablecer Contraseña',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
                    //Ir a inicio de sesión
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      child: const Text(
                        'Regresar a Inicio de Sesión',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
