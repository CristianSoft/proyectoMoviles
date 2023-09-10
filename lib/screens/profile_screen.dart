import 'package:flutter/material.dart';
import 'package:proyecto/providers/login_provider.dart';
import 'package:proyecto/providers/person_provider.dart';
import 'package:proyecto/screens/edit_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto/screens/login_screen.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/myprofile';
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final List<String> intereses = ['Texto 1', 'Texto 2', 'Texto 3','Texto 1', 'Texto 2', 'Texto 3'];
  late List<Widget> containerWidgets;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Map<String, dynamic>? _userData;

  Future<void> _loadUserData() async {
    try {
      final userCollection = _firestore.collection('persona');
      final userDoc = await userCollection.doc(_auth.currentUser?.uid).get();

      if (userDoc.exists) {
        setState(() {
          _userData = userDoc.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print('Error al cargar los datos del usuario: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData(); 
  }

  @override
  Widget build(BuildContext context) {
    containerWidgets = buildContainersWithBorder(intereses);
    final String? userName = _userData?['nombre'] as String?;
    final String? userAge = _userData?['edad'] as String?;
    final String? userGender = _userData?['genero'] as String?;
    final String? userDescription = _userData?['descripcion'] as String?;
    final String? userFaculty = _userData?['facultad'] as String?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario', 
        style: TextStyle(
        color: Colors.white,
        fontSize: 15, 
        fontWeight: FontWeight.normal)),
        backgroundColor: const Color.fromARGB(255, 249, 22, 89),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Foto de perfil
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              width: 150.0,
              height: 150.0,
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 249, 22, 89),
                  width: 4.0,),
                image: const DecorationImage(
                  image: AssetImage('lib/images/usuarioGenerico.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          //Nombre Usuario
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  userName?? 'Nombre de usuario no disponible',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10.0), // Espacio entre el texto y el botón
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar el botón
                    Navigator.pushNamed(context, EditUserProfileScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), 
                    backgroundColor: const Color.fromARGB(255, 249, 22, 89), // Color de fondo del botón
                    padding: const EdgeInsets.all(16.0), // Espaciado interno del botón
                  ),
                  child: const Icon(
                    Icons.edit, // Icono del botón (puedes cambiarlo)
                    color: Colors.white, // Color del icono
                  ),
                ),
              ],
            ),
          ),
          // Información del usuario
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child:
                Text(
                  userDescription?? 'Descripción no disponible',
                  style: const TextStyle(fontSize: 16.0),
                )
            ),
          ),

          //Datos importantes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Alinea los elementos en la fila
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Define los bordes redondeados
                   border: Border.all(
                    color: Colors.red, // Color del borde
                    width: 2.0, // Ancho del borde
                  ), 
                ),
                child: Center(
                  child: Text(
                    userGender?? 'Genero no disponible',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Define los bordes redondeados
                   border: Border.all(
                    color: Colors.red, // Color del borde
                    width: 2.0, // Ancho del borde
                  ), 
                ),
                child: Center(
                  child: Text(
                    userFaculty?? 'Facultad no disponible',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Define los bordes redondeados
                   border: Border.all(
                    color: Colors.red, // Color del borde
                    width: 2.0, // Ancho del borde
                  ), 
                ),
                child: Center(
                  child: Text(
                    userAge?? ' Edad no disponible',
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),

          //Intereses
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0), // Aplicar espaciado solo hacia abajo
                child: Align(
                  alignment: Alignment.centerLeft, // Alinear el texto a la izquierda
                  child: Text(
                    'Intereses',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              //Primer categoria de intereses
              Wrap(
                spacing: 16.0, // Espaciado horizontal entre contenedores
                runSpacing: 16.0, // Espaciado vertical entre filas de contenedores
                children: containerWidgets,
              ),
            ]
            ),
          ),
          // Spacer para empujar la opción de cierre de sesión hacia abajo
          const Spacer(),

          // Botón para cerrar sesión
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                 //sign out function
                void signOut() {
                  //get auth sevrice
                  final authService = Provider.of<LoginProvider>(context, listen: false);
                  authService.logout();
                  Navigator.pushNamed(context, LoginScreen.routeName);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Color de fondo del botón de cierre de sesión
                padding: const EdgeInsets.all(16.0), // Espaciado interno del botón
              ),
              child: const Text(
                'Cerrar Sesión',
                style: TextStyle(
                  color: Colors.white, // Color del texto
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}

Widget _buildContainerWithBorder(String text) {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Define los bordes redondeados
          border: Border.all(
            color: Colors.red, // Color del borde
            width: 2.0, // Ancho del borde
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
}

List<Widget> buildContainersWithBorder(List<String> texts) {
  List<Widget> containers = [];

  for (String text in texts) {
    containers.add(_buildContainerWithBorder(text));
  }

  return containers;
}
