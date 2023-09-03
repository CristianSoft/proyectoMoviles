import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/password_reset_provider.dart';

class PasswordResetScreen extends StatelessWidget {
  static const routeName = '/password-reset';

  PasswordResetScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passwordResetProvider = Provider.of<PasswordResetProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restablecer Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Reestablecer Contraseña',
              style: TextStyle(
                fontSize: 25.0,
                color: Color(0xFFF91659),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              onChanged: (email) {
                final passwordResetProvider =Provider.of<PasswordResetProvider>(context, listen: false);

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
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text;
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
                }
              },
              child: const Text('Restablecer Contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
