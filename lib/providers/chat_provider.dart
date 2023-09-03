import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto/dtos/message.dart';

class ChatProvider extends ChangeNotifier {
  //get instance of auth and firestore

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  //SEND MESSAGE

  Future<void> sendMessage(String receiverId, message, Type type) async {
    //get Current User Information
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create a new message

    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        timestamp: timestamp,
        message: message,
        type: type);
    //construct a chat room id from current user id and the receiver id(sorted to ensure uniqueness)

    List<String> ids = [currentUserId, receiverId];
    ids.sort(); //sort the ids to ensure chat room id is always the same for any pair of people (juan y pedro lo mismo que pedro y juan)
    String chatRoomId = ids.join(
        "_"); //combine the ids into a single string to use as a chatroomid

    //add a new message to database
    //ceeates chatrroms collection and inside create another collection for messages where we add the messages
    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //GET MESSAGES

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    //construct chat room id from use ids (sorted to ensure it matches the id when sending messages)
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  ////FUNCION IMAGENES////

  Future<void> sendChatImage(
      File file, String userId, String otherUserId) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path

    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    final ref = storage.ref().child(
        'image/$chatRoomId/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(otherUserId, imageUrl, Type.image);
  }
}
