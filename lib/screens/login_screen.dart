import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/login_provider.dart';

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
          children: [
            Wrap(
              children: [Container(
                  width: double.infinity,
                  color: const Color(0xFFF91659),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'PoliMatch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 48.0,
                            color: Colors.white,
                          ),
                        ),
                        Image.asset(
                          'lib/images/logoLogin.png', // Ruta de la imagen del logotipo
                          width: 200.0, // Ancho de la imagen
                          height: 200.0, // Alto de la imagen
                        ),
                      ],
                    ),
                  ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration:
                        const InputDecoration(labelText: 'Usuario o Correo'),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      // Implementa la lógica para restablecer la contraseña
                    },
                    child: const Text('¿Olvidó su contraseña?'),
                  ),
                  Consumer<LoginProvider>(
                    builder: (context, authProvider, child) {
                      return ElevatedButton(
                        onPressed: () async {
                          try {
                            await authProvider.login(
                              _emailController.text,
                              _passwordController.text,
                            );
                            // Redirige al usuario a la pantalla de perfil en lugar de la pantalla principal
                            /*Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen()),
                    );*/
                          } catch (e) {
                            // Manejo de errores de inicio de sesión
                            print(e);
                          }
                        },
                        child: const Text('Iniciar Sesión'),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      // Implementa la navegación a la pantalla de registro
                    },
                    child: const Text('¿No tiene cuenta? Registrarse gratis'),
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
