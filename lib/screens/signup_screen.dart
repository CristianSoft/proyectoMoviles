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
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedFaculty;
  String? _selectedGender;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _successMessage;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(children: [
              Container(
                  width: double.infinity,
                  color: const Color(0xFFF91659),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
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
                    ),
                  )),
            ]),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Registro de Usuario',
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nombre*'),
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
                    decoration: const InputDecoration(labelText: 'Facultad*'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(labelText: 'Edad'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField(
                    value: _selectedGender, // Asigna el valor seleccionado
                    items: ['Femenino', 'Masculino', 'Otro']
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (value) {
                      //Actualiza la variable _selectedFaculty
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Género'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        labelText: 'Correo institucional*'),
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
                    obscureText:
                        _obscurePassword, // Aplicar la visibilidad de la contraseña
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirmar contraseña',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          // Verifica que _selectedFaculty no sea nulo antes de continuar
                          if (_selectedFaculty != null) {
                            //Firebase Authentication
                            UserCredential authResult = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );

                            //Llama a la función para registrar al usuario en Firestore a través de PersonProvider
                            await Provider.of<PersonProvider>(context,
                                    listen: false)
                                .addPerson(
                              id: authResult.user!.uid,
                              nombre: _nameController.text,
                              facultad: _selectedFaculty!,
                              correo: _emailController.text,
                              clave: _passwordController.text,
                              edad: int.tryParse(_ageController.text),
                              descripcion: _descriptionController.text,
                              genero: _selectedGender!,
                            );

                            // Registro exitoso
                            setState(() {
                              _successMessage =
                                  'Registro exitoso. ¡Bienvenido!';
                              _errorMessage = null;
                            });

                            // Limpia los campos
                            _nameController.clear();
                            _emailController.clear();
                            _passwordController.clear();
                            _confirmPasswordController.clear();
                            _ageController.clear();
                            _descriptionController.clear();
                            _selectedFaculty = null;
                            _selectedGender = null;

                            //Navigator.pushNamed(context, LoginScreen.routeName);
                          } else {
                            print(
                                'Por favor, selecciona una facultad antes de continuar.');
                          }
                        } catch (e) {
                          // Registro fallido
                          setState(() {
                            _errorMessage = 'Error al registrar: $e';
                            _successMessage = null;
                          });
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
                  ),
                  const SizedBox(height: 8.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    child: const Text(
                      '¿Ya tienes cuenta? Inicia Sesión',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  if (_successMessage != null)
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        _successMessage!,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red, // Color para el mensaje de error
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
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
