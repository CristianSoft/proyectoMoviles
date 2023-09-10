import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/login_provider.dart';
import 'package:proyecto/providers/signup_provider.dart';
import 'package:proyecto/providers/person_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto/screens/login_screen.dart';
import 'package:proyecto/widgets/interfaz_inicio.dart';

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

  void cleanData() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _ageController.clear();
    _descriptionController.clear();
    _selectedFaculty = null;
    _selectedGender = null;
  }

  Future<void> addPerson() async {
    UserCredential authResult =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    await Provider.of<PersonProvider>(context, listen: false).addPerson(
      id: authResult.user!.uid,
      nombre: _nameController.text,
      facultad: _selectedFaculty!,
      correo: _emailController.text,
      clave: _passwordController.text,
      edad: int.tryParse(_ageController.text),
      descripcion: _descriptionController.text,
      genero: _selectedGender!,
      imagen: 'lib/images/usuarioGenerico.png',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              InterfazInicio(),
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
                padding:
                    const EdgeInsets.only(top: 5.0, right: 30.0, left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Nombre*'),
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField(
                      value: _selectedFaculty,
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
                      decoration:
                          const InputDecoration(labelText: 'Descripción'),
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
                      obscureText: _obscurePassword,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirmar contraseña*',
                        suffixIcon: IconButton(
                          icon: Icon(_obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            // Cambiar el estado de la visibilidad de la contraseña
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      obscureText:
                          _obscureConfirmPassword, // Aplicar la visibilidad de la contraseña
                    ),
                    const SizedBox(height: 16.0),
                    //Registrarse
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            // Verifica que _selectedFaculty no sea nulo antes de continuar
                            if (_selectedFaculty != null &&
                                _nameController.text.isNotEmpty &&
                                _emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty &&
                                _confirmPasswordController.text.isNotEmpty &&
                                _ageController.text.isNotEmpty &&
                                _descriptionController.text.isNotEmpty &&
                                _selectedGender != null) {
                              await addPerson();
                              //Registro exitoso
                              setState(() {
                                _successMessage = 'Registro exitoso. ¡Bienvenido ${_nameController.text}!';
                                _errorMessage = null;
                              });
                              //Limpia los campos
                              cleanData();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Por favor, complete todos los campos antes de continuar.'),
                                ),
                              );
                            }
                          } catch (e) {
                            // Registro fallido
                            setState(() {
                              _errorMessage = 'Error al registrar: $e';
                              _successMessage = null;
                            });
                            cleanData();
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
                    //Ir a inicio de sesión
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
                  ],
                ),
              ),
            ],
          ),
        ),
        //Mensaje de registro exitoso
        if (_successMessage != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MaterialBanner(
              backgroundColor: Colors.grey,
              content: Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                child: Text(
                  _successMessage!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _successMessage = null;
                    });
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: const Text(
                    'Cerrar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        //Mensaje de registro fallido
        if (_errorMessage != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MaterialBanner(
              backgroundColor: Colors.grey,
              content: Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _errorMessage = null;
                    });
                  },
                  child: const Text(
                    'Cerrar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ]),
    );
  }
}
