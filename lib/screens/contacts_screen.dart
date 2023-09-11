import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/login_provider.dart';
import 'package:proyecto/screens/chat_screen.dart';
import 'package:proyecto/screens/login_screen.dart';

class ContactsScreen extends StatefulWidget {
  static const routeName = '/contacts';
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign out function
  void signOut() {
    //get auth sevrice
    final authService = Provider.of<LoginProvider>(context, listen: false);
    authService.logout();
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0),
              child: Image.asset('lib/images/LogoPolimatchSmall.png'),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Bandeja de Entrada',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFF91659),
                ),
              ),
            )
          ],
        ),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('persona').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    //all users except the current
    if (_auth.currentUser!.email != data['correo']) {
      if (data.containsKey('match')) {
        //lista de matches
        List<String> arrayOfMatches = List<String>.from(data['match']);
        for (var element in arrayOfMatches) {
          //if the mail of the current user appears in someone's else matches list
          //it is displayed in the chat screen
          if (element == _auth.currentUser!.email) {
            return ListTile(
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.account_box_rounded),
              ),
              title: Text(data['nombre']),
              onTap: () {
                //ir al chat seleccionado
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      receiverUserEmail: data['correo'],
                      receiverUserId: data['uid'],
                      receiverUserName: data['nombre'],
                    ),
                  ),
                );
              },
            );
          } else {
            continue;
          }
        }
      } else {
        return Container();
      }
    } else {
      return Container();
    }
    return Container();
  }
}
