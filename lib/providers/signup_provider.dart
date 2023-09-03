import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/dtos/person_model.dart';

class SignUpProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(Person person) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: person.email,
        password: person.password,
      );
    } catch (e) {
      print(e);
    }
  }
}
