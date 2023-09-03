import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/login_provider.dart';
import 'package:proyecto/screens/contacts_screen.dart';
import 'package:proyecto/screens/password_reset_screen.dart';
import 'package:proyecto/screens/signup_screen.dart';
import 'package:proyecto/widgets/interfaz_inicio.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InterfazInicio(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Inicio de Sesión',
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
              padding: const EdgeInsets.only(top: 8.0, right: 25.0, left: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        labelText: 'Correo institucional'),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 8.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, PasswordResetScreen.routeName);
                    },
                    child: const Text(
                      '¿Olvidó su contraseña?',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Consumer<LoginProvider>(
                    builder: (context, authProvider, child) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              await authProvider.login(
                                _emailController.text,
                                _passwordController.text,
                              );
                              // Redirige al usuario a la pantalla de perfil en lugar de la pantalla principal
                              Navigator.pushNamed(
                                  context, ContactsScreen.routeName);
                            } catch (e) {
                              // Manejo de errores de inicio de sesión
                              print(e);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        child: const Text(
                          '¿No tiene cuenta? Registrarse gratis',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
