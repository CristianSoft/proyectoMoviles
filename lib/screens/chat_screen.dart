import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/chat_provider.dart';
import 'package:proyecto/dtos/message.dart';
import 'package:proyecto/widgets/chat_bubble.dart';
import 'package:proyecto/widgets/text_field.dart';

class ChatScreen extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;
  final String receiverUserName;
  final String receiverImage;
  const ChatScreen(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserId,
      required this.receiverUserName,
      required this.receiverImage});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatProvider _chatProvider = ChatProvider();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _isUploading = false;
  void sendMessage() async {
    //enviar mensaje solo si no esta vacio
    if (_messageController.text.isNotEmpty) {
      //PARA LA IMAGEN LE AÑADÍ EL TIPO
      await _chatProvider.sendMessage(
          widget.receiverUserId, _messageController.text, Type.text);
      //Provider.of<ChatProvider>(context, listen: false)
      //    .sendMessage(widget.receiverUserId, _messageController.text);
      //CLEAR THE CONTROLLER TEXT IN THE MESSAGE BOX
      _messageController.clear();
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFf91659),
        title: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CircleAvatar(backgroundImage: getProfileImage()),
                ),
                Text(
                  widget.receiverUserName,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(children: [
        //messages
        Expanded(
          child: _buildMessageList(),
        ),

        //user input
        _buildMessageInput(),

        const SizedBox(
          height: 25.0,
        )
      ]),
    );
  }

  //build Message List
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatProvider.getMessages(
          widget.receiverUserId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading... ');
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  //build Message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //align the messages to the right if the sender is the current, otherwise left
    var aligment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    var color = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? const Color(0XFFf91659)
        : Colors.grey;

    return Container(
      alignment: aligment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            ChatBubble(
              message: data['message'],
              color: color,
              type: data['type'],
            ),
          ],
        ),
      ),
    );
  }

  //build Message input

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    // Pick an image
                    final XFile? image = await picker.pickImage(
                        source: ImageSource.camera, imageQuality: 70);
                    if (image != null) {
                      log('Image Path: ${image.path}');
                      setState(() => _isUploading = true);

                      await _chatProvider.sendChatImage(
                        File(image.path),
                        _firebaseAuth.currentUser!.uid,
                        widget.receiverUserId,
                      );
                      setState(() => _isUploading = false);
                    }
                  },
                  icon: const Icon(Icons.camera_alt_rounded,
                      color: Color(0XFFf91659)),
                ),
              )),

          //texfield
          Flexible(
            flex: 4,
            child: MyTextField(
                controller: _messageController,
                hintText: 'Mensaje',
                obscureText: false),
          ),

          //send button
          Flexible(
            flex: 1,
            child: IconButton(
                onPressed: sendMessage,
                icon: const Icon(
                  Icons.send,
                  color: Color(0XFFf91659),
                )),
          )
        ],
      ),
    );
  }

  ImageProvider getProfileImage() {
    return widget.receiverImage == ''
        ? const AssetImage('lib/images/usuarioGenerico.png')
        : NetworkImage(widget.receiverImage) as ImageProvider<Object>;
  }
}
