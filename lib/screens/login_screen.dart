import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'auth_provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Usuario o Correo'),
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
            /*Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return ElevatedButton(
                  onPressed: () async {
                    try {
                      await authProvider.loginWithEmailAndPassword(
                        _emailController.text,
                        _passwordController.text,
                      );
                      // Redirige al usuario a la pantalla de perfil en lugar de la pantalla principal
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()),
                      );
                    } catch (e) {
                      // Manejo de errores de inicio de sesión
                      print(e);
                    }
                  },
                  child:const Text('Iniciar Sesión'),
                );
              },
            ),*/
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implementa la lógica para iniciar sesión con Google
              },
              child: const Text('Continuar con Google'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45.0),
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0)
              ),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                // Implementa la lógica para iniciar sesión con Facebook
              },
              child: const Text('Continuar con Facebook'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45.0),
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0)
              ),
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
    );
  }
}
