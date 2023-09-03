import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/dtos/person_model.dart';

class SignUpProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(Person person) async {
    try {
      if (!isValidEpnEmail(person.email)) {
        print('Correo electrónico no válido para @epn.edu.ec');
        return; // Salir de la función si el correo no es válido
      }
      await _auth.createUserWithEmailAndPassword(
        email: person.email,
        password: person.password,
      );
    } catch (e) {
      print(e);
    }
  }

  //Validar el correo electrónico con dominio @epn.edu.ec
  bool isValidEpnEmail(String email) {
    final RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@epn\.edu\.ec$');
    return regex.hasMatch(email);
  }
}
