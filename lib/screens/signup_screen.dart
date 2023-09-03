import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/login_provider.dart';
import 'package:proyecto/providers/signup_provider.dart';
import 'package:proyecto/providers/person_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _selectedFaculty;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
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
                )),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 30.0, left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField(
                    value: _selectedFaculty, // Asigna el valor seleccionado
                    items: ['FIS', 'FIM', 'FIQA', 'FIEE', 'FCA']
                        .map((faculty) => DropdownMenuItem(
                              value: faculty,
                              child: Text(faculty),
                            ))
                        .toList(),
                    onChanged: (value) {
                      //Actualiza la variable _selectedFaculty
                      setState(() {
                        _selectedFaculty = value;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Facultad'),
                  ),
                  const SizedBox(height: 16.0),
                   TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Correo institucional'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          // Cambiar el estado de la visibilidad de la contraseña
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscurePassword, // Aplicar la visibilidad de la contraseña
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirmar Contraseña',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility
                        ),
                        onPressed: () {
                          // Cambiar el estado de la visibilidad de la contraseña
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    obscureText:
                        _obscureConfirmPassword, // Aplicar la visibilidad de la contraseña
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        // Verifica que _selectedFaculty no sea nulo antes de continuar
                        if (_selectedFaculty != null) {
                          //Llama a la función para registrar al usuario en Firestore a través de PersonProvider
                          await Provider.of<PersonProvider>(context, listen: false).addPerson(
                            nombre: _nameController.text,
                            facultad: _selectedFaculty!,
                            correo: _emailController.text,
                            clave: _passwordController
                                .text, // Utiliza la contraseña ingresada desde el formulario
                          );
                          //Firebase Authentication
                          final authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        } else {
                          print(
                              'Por favor, selecciona una facultad antes de continuar.');
                        }
                      } catch (e) {
                        print(
                            'Error al registrar al usuario en Firestore o en Firebase Authentication: $e');
                      }
                    },
                    child: const Padding(
                       padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Registrarse',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    child: const Text(
                      '¿Ya tienes cuenta? Inicia Sesión',
                      style: TextStyle(fontSize: 16.0,),
                      ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
