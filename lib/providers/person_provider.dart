import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/dtos/person_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_provider.dart';

class PersonProvider extends ChangeNotifier {
  final CollectionReference _personCollection =
      FirebaseFirestore.instance.collection('persona');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var setOptions = SetOptions(merge: true);

  List<Person> _listaUsuarios = [];
  UnmodifiableListView<Person> get usuariosGetter =>
      UnmodifiableListView(_listaUsuarios);
  List<Person> _listaSugerencias = [];
  UnmodifiableListView<Person> get sugerenciasGetter =>
      UnmodifiableListView(_listaSugerencias);

  Future<void> addPerson({
    required String nombre,
    required String facultad,
    required String correo,
    required String clave,
    required String id,
    int? edad,
    String? descripcion,
    String? genero,
    String? imagen,
  }) async {
    try {
      await _personCollection.doc(id).set({
        'uid': id,
        'nombre': nombre,
        'facultad': facultad,
        'correo': correo,
        'clave': '',
        'edad': edad,
        'descripcion': descripcion,
        'genero': genero,
        'imagen': imagen,
      }, setOptions);
      notifyListeners();
    } catch (e) {
      print('Error al agregar la persona: $e');
      throw e;
    }
  }

  

  Future<void> initPersonList() async {
    final querySnapShot =
        await FirebaseFirestore.instance.collection('persona').get();

    _listaUsuarios = querySnapShot.docs.map((doc) {
      final data = doc.data();
      if (data['imagen'] == null) {
        data['imagen'] = "";
      }
      return Person(
          id: data['uid'],
          email: data['correo'],
          faculty: data['facultad'],
          name: data['nombre'],
          password: '',
          descripcion: data['descripcion'],
          edad: data['edad'],
          genero: data['genero'],
          imagen: data['imagen']);
    }).toList();
    print("Estoy en person");
    notifyListeners();
  }



  Future<void> initSugerenciasList() async {
    
    final querySnapShot1 = await FirebaseFirestore.instance
        .collection('persona')
        .where('correo', isEqualTo: _auth.currentUser?.email)
        .get();
        String genero= querySnapShot1.docs.first.data()['genero'];
        if (genero != "Masculino") {
          genero="Masculino";
        }else{
          genero="Femenino";
        }

    final querySnapShot = await FirebaseFirestore.instance
        .collection('persona')
        .where('genero', isEqualTo: genero)
        .where('correo', isNotEqualTo: _auth.currentUser?.email)
        .get();

    _listaSugerencias = querySnapShot.docs.map((doc) {
      final data = doc.data();
      if (data['imagen'] == null) {
        data['imagen'] = "";
      }
      return Person(
          id: data['uid'],
          email: data['correo'],
          faculty: data['facultad'],
          name: data['nombre'],
          password: '',
          descripcion: data['descripcion'],
          edad: data['edad'],
          genero: data['genero'],
          imagen: data['imagen']);
    }).toList();
    notifyListeners();
  }

  Person getPersonById(String id) {
    return _listaUsuarios.firstWhere((element) => element.id == id);
  }
}
