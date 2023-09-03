import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordResetProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _resetError;

  String? get resetError => _resetError;

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _resetError = null; // Restablece cualquier error previo
    } catch (e) {
      _resetError = e.toString();
    }
    notifyListeners();
  }

  //Validación de correo electrónico
  bool validateEmail(String email) {
   // final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@epn\.edu\.ec$');
    final emailRegExp = RegExp(r'.*');
    return emailRegExp.hasMatch(email);
  }
}
