import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/login_provider.dart';
import 'package:proyecto/screens/contacts_screen.dart';
import 'package:proyecto/screens/password_reset_screen.dart';
import 'package:proyecto/screens/signup_screen.dart';
import 'package:proyecto/widgets/interfaz_inicio.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

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
                  //Campos de ingreso de información
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        labelText: 'Correo institucional*'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña*',
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          //Cambiar el estado de la visibilidad de la contraseña
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    obscureText:_obscurePassword,
                  ),
                  const SizedBox(height: 8.0),
                  //Olvido su contraseña
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, PasswordResetScreen.routeName);
                    },
                    child: const Text(
                      '¿Olvidó su contraseña?',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  //Iniciar Sesión
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
                              //CAMBIAR LA RUTA A LA QUE SE DIRIGE
                              Navigator.pushNamed(context, ContactsScreen.routeName);
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
                  //Registrarse
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
