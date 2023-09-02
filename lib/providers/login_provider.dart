import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  // Método para realizar el inicio de sesión
  Future<void> login(String email, String password) async {
    try {
      // Validar el correo electrónico con el dominio @epn.edu.ec
      if (!isValidEpnEmail(email)) {
        print('Correo electrónico no válido para @epn.edu.ec');
        return; // Salir de la función si el correo no es válido
      }

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = userCredential.user;
      notifyListeners();
    } catch (e) {
      print('Error de inicio de sesión: $e');
    }
  }

  // Método para cerrar sesión
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }

  // Función para validar el correo electrónico con dominio @epn.edu.ec
  bool isValidEpnEmail(String email) {
    final RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@epn\.edu\.ec$');
    return regex.hasMatch(email);
  }
}
