import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  //para l aimagen le añadí late
  late final String senderId;
  late final String senderEmail;
  late final String receiverId;
  late final String message;
  late final Timestamp timestamp;
  //imagen
  late final Type type;

  Message(
      {required this.senderId,
      required this.senderEmail,
      required this.receiverId,
      required this.timestamp,
      required this.message,
      //imagen
      required this.type});

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'timestamp': timestamp,
      'message': message,
      //imagen
      'type': type.name
    };
  }

  //IMAGEN
  Message.fromJson(Map<String, dynamic> json) {
    receiverId = json['receiverId'].toString();
    message = json['msg'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    senderId = json['senderId'].toString();
  }
}

//imagen
enum Type { text, image }
