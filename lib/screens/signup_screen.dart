import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/dtos/person_model.dart';
import 'package:proyecto/providers/signup_provider.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  late String _selectedFaculty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: () {
                    // Mostrar/ocultar la contraseña
                  },
                ),
              ),
              obscureText: true,
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmar Contraseña',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: () {
                    // Mostrar/ocultar la contraseña
                  },
                ),
              ),
              obscureText: true,
            ),
            DropdownButtonFormField(
              value: _selectedFaculty, // Asigna el valor seleccionado
              items: ['FIS', 'FIM', 'FIQA', 'FIEE']
                  .map((faculty) => DropdownMenuItem(
                        value: faculty,
                        child: Text(faculty),
                      ))
                  .toList(),
              onChanged: (value) {
                // Cuando cambie la facultad seleccionada, actualiza la variable _selectedFaculty
                setState(() {
                  _selectedFaculty = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Facultad'),
            ),
            ElevatedButton(
              onPressed: () {
                // Validar y registrar al usuario
                final user = Person(
                  name: _nameController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                  faculty:
                      _selectedFaculty, // Actualiza esto con la facultad seleccionada
                );
                Provider.of<SignUpProvider>(context, listen: false)
                    .signUp(user);
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
