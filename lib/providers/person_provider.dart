import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonProvider extends ChangeNotifier {
  final CollectionReference _personCollection =
      FirebaseFirestore.instance.collection('persona');

  Future<void> addPerson({
    required String nombre,
    required String facultad,
    required String correo,
    required String clave,
  }) async {
    try {
      await _personCollection.add({
        'nombre': nombre,
        'facultad': facultad,
        'correo': correo,
        'clave': clave,
      });
      notifyListeners();
    } catch (e) {
      print('Error al agregar la persona: $e');
      throw e;
    }
  }
}