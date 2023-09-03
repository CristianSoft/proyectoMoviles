import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto/dtos/person_model.dart';

class PersonProvider extends ChangeNotifier {
  final CollectionReference _personCollection =
      FirebaseFirestore.instance.collection('persona');

  List<Person> _listaUsuarios = [];
  UnmodifiableListView<Person> get usuariosGetter =>
      UnmodifiableListView(_listaUsuarios);
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

  Future<void> _initEventsList() async {
    final querySnapShot =
        await FirebaseFirestore.instance.collection('events').get();

    _listaUsuarios = querySnapShot.docs.map((doc) {
      final data = doc.data();
      print('////////////////// HOLA ////////////////');
      return Person(
          email: data['correo'],
          faculty: data['facultad'],
          name: data['nombre'],
          password: data['clave'],
          descripcion: "",
          edad: 0,
          genero: "",
          imagen: "");
    }).toList();

    print(_listaUsuarios);
    notifyListeners();
  }
}
