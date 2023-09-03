import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/login_provider.dart';
import 'package:proyecto/screens/signup_screen.dart';

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
            Wrap(
              children: [
                Container(
                    width: double.infinity,
                    color: const Color(0xFFF91659),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
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
                      ),
                    )
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, right: 25.0, left: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration:
                        const InputDecoration(labelText: 'Correo institucional'),
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
                      //Navigator.pushNamed(context, LoginFailedScreen.routeName);
                    },
                    child: const Text(
                      '¿Olvidó su contraseña?',
                      style: TextStyle(fontSize: 16.0,),
                    ),
                  ),
                  const SizedBox(height: 16.0),
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
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    child: const Text(
                      '¿No tiene cuenta? Registrarse gratis',
                      style: TextStyle(fontSize: 16.0,),
                      ),
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
