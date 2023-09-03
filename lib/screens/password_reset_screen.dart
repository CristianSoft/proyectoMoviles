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
        backgroundColor: const Color(0xFFF91659),
        iconTheme:  const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Wrap(children: [
              Container(
                  width: double.infinity,
                  color: const Color(0xFFF91659),
                  child: Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 10.0),
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
                            width: 200.0,
                            height: 200.0,
                          ),
                        ],
                      ),
                  )),
            ]),
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
                          Provider.of<PasswordResetProvider>(context,
                              listen: false);
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
                        await passwordResetProvider.resetPassword(email);
                        final resetError = passwordResetProvider.resetError;
                        if (resetError == null) {
                          // Restablecimiento de contraseña exitoso
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Se ha enviado un correo de restablecimiento de contraseña.'),
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
          ],
        ),
      ),
    );
  }
}