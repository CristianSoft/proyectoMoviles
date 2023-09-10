import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EditProfileProvider extends ChangeNotifier {
  // for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

//update the image URL os a person
  Future<void> updateProfilePicture(String userId, imageUrl) async {
    await _fireStore
        .collection('persona')
        .doc(userId)
        .update({'imagen': '$imageUrl'});
  }

//upload the profile picture to fire storage
  Future<void> uploadProfilePicture(File file, String userId) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //contructing the path to store the image in firebase storage
    final ref = storage
        .ref()
        .child('profile/$userId/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'profile/$ext'))
        .then((p0) {
      //to check the bytes transferred
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await updateProfilePicture(userId, imageUrl);
  }
}
