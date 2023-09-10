import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MatchesProvider extends ChangeNotifier {
  List<dynamic> misMatches = [];
  List<dynamic> misLikes = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Método para cargar los datos desde Firebase
  Future<void> obtenerMatches() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('persona')
          .where('correo', isEqualTo: _auth.currentUser?.email)
          .get();

      misMatches = querySnapshot.docs.map((doc) => doc['match']).toList();
      print(misMatches[0].toString());
      notifyListeners();
    } catch (e) {
      // Manejo de errores, por ejemplo, imprimir el error
      print('Error al obtener datos: $e');
    }
  }

  Future<void> obtenerLikes() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('persona')
          .where('correo', isEqualTo: _auth.currentUser?.email)
          .get();

      misLikes = querySnapshot.docs.map((doc) => doc['match']).toList();
      print(misLikes[0].toString());
      notifyListeners();
    } catch (e) {
      // Manejo de errores, por ejemplo, imprimir el error
      print('Error al obtener datos: $e');
    }
  }

  Future<void> addEmailToMatch(String email) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('persona');
      final userDoc = await userCollection.doc(_auth.currentUser?.uid).get();

      if (userDoc.exists) {
        // Obtener el arreglo actual "match"
        final List<String> match = List.from(userDoc.data()?['like'] ?? []);

        // Agregar el nuevo correo al arreglo
        match.add(email);

        // Actualizar el documento con el nuevo arreglo "match"
        await userCollection
            .doc(_auth.currentUser?.uid)
            .update({'like': match});
      }
      notifyListeners();
    } catch (e) {
      print('Error al agregar el correo a "match": $e');
    }
  }

  bool sonMatch(String correoMatch){
    if (misLikes.contains(correoMatch)) {
      print("si son match");
      return true;
    }else{
      print("No son match");
      return false;
    }
  }
}
