import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MatchesProvider extends ChangeNotifier {
  List<dynamic> misMatches = [];
  UnmodifiableListView<dynamic> get misMatchesGetter =>
      UnmodifiableListView(misMatches);
  List<dynamic> misLikes = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> obtenerMatches() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('persona')
          .where('correo', isEqualTo: _auth.currentUser?.email)
          .get();

      misMatches = querySnapshot.docs.map((doc) => doc['match']).toList();
      print(misMatches[1]);
      notifyListeners();
    } catch (e) {
      print('Error al obtener datos: $e');
    }
  }

  Future<void> obtenerLikes() async {
    //try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('persona')
        .where('correo', isEqualTo: _auth.currentUser?.email)
        .get();

    misLikes = querySnapshot.docs.map((doc) => doc['like']).toList();
    print("///////////// aqui estan los likes");
    print(misLikes[0].toString());
    notifyListeners();
    /* } catch (e) {
      // Manejo de errores, por ejemplo, imprimir el error
      print('Error al obtener datos: $e');
    }*/
  }
  /*
  Future<void> addEmailToMatch(String? email, String usuarioId) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('persona');
      final userDoc = await userCollection.doc(usuarioId).get();
      if (userDoc.exists) {
        final List<String> match = List.from(userDoc.data()?['match'] ?? []);
        match.add(email!);
        await userCollection
            .doc(usuarioId)
            .update({'match': match});
      }
      notifyListeners();
    } catch (e) {
      print('Error al agregar el correo a "match": $e');
    }
  }*/
  Future<void> addEmailToMatch(String? email, String usuarioId) async {
  try {
    final userCollection = FirebaseFirestore.instance.collection('persona');
    final userDoc = await userCollection.doc(usuarioId).get();
    if (userDoc.exists) {
      final List<String> match = List.from(userDoc.data()?['match'] ?? []);

      // Verificar si el correo no existe en la lista "match"
      if (!match.contains(email)) {
        // Si no existe, agrégalo a la lista
        match.add(email!);
        await userCollection
            .doc(usuarioId)
            .update({'match': match});
      } else {
        // El correo ya existe en la lista, puedes manejar esta situación según tus necesidades
        print('El correo ya existe en la lista de "match".');
      }
    }
    notifyListeners();
  } catch (e) {
    print('Error al agregar el correo a "match": $e');
  }
}

  Future<void> addEmailToLike(String email) async {
  try {
    final userCollection = FirebaseFirestore.instance.collection('persona');
    final userDoc = await userCollection.doc(_auth.currentUser?.uid).get();

    if (userDoc.exists) {
      final List<String> like = List.from(userDoc.data()?['like'] ?? []);
      if (!like.contains(email)) {
        like.add(email);
        await userCollection.doc(_auth.currentUser?.uid).update({'like': like});
      } else {
        print('El correo ya existe en la lista de "like".');
      }
    }
    notifyListeners();
  } catch (e) {
    print('Error al agregar el correo a "like": $e');
  }
}


Future<bool> sonMatch(String correoPersonaLigueada) async {
  try {
    final userCollection = FirebaseFirestore.instance.collection('persona');
    final userDocActual = await userCollection.doc(_auth.currentUser?.uid).get();
    final List<String> likesUsuarioActual = List.from(userDocActual.data()?['like'] ?? []);
    final userDocLigueado = await userCollection.where('correo', isEqualTo: correoPersonaLigueada).get();
    if (userDocActual.exists && userDocLigueado.docs.isNotEmpty) {
      final List<String> likesPersonaLigueada = List.from(userDocLigueado.docs[0].data()?['like'] ?? []);

      if (likesUsuarioActual.contains(correoPersonaLigueada) && likesPersonaLigueada.contains(_auth.currentUser?.email)) {
        print("Si son match");
        return true;
      }
    }
  } catch (e) {
    print('Error en sonMatch: $e');
  }
  return false; 
}


}
