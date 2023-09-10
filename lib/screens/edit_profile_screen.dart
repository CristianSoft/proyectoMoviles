import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/dtos/person_model.dart';
import 'package:proyecto/providers/edit_profile_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto/providers/person_provider.dart';
import 'package:proyecto/widgets/image_profile.dart';

class EditUserProfileScreen extends StatefulWidget {
  static const routeName = '/edit_myprofile';
  const EditUserProfileScreen({super.key});

  @override
  State<EditUserProfileScreen> createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  final List<String> intereses = [
    'Leer',
    'Cocinar',
    'Jugar al baloncesto',
    'Hacer ejercicio',
    'Viajar',
    'Ver películas',
    'Escuchar música',
    'Bailar',
    'Dibujar',
    'Pintar',
  ];

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late List<String> miIntereses = [];
  late String _selectedGender = 'Masculino';
  late String _selectedFaculty = 'FIS';
  late List<Widget> containerWidgets;

  TextEditingController _nombreUsuarioController =
      TextEditingController(text: 'Cristian Verduga');
  TextEditingController _descripcionUsuarioController = TextEditingController(
      text:
          'Soy un chico que ama la vida, me gustan las actividades que me sacan de mi zona de confort.');
  TextEditingController _generoController =
      TextEditingController(text: 'Masculino');
  TextEditingController _facultadController =
      TextEditingController(text: 'Facultad de Sistemas');
  TextEditingController _edadController =
      TextEditingController(text: '21 años');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil de Usuario',
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildProfileImage(context),
                const SizedBox(
                    width: 10.0), // Espacio entre el texto y el botón
                ElevatedButton(
                  onPressed: () async {
                    // Escoger foto desde la galeria
                    final ImagePicker picker = ImagePicker();
                    // Pick an image
                    final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery, imageQuality: 70);
                    //subir la foto
                    setState(() {
                      if (image != null) {
                        Provider.of<EditProfileProvider>(context, listen: false)
                            .uploadProfilePicture(
                          File(image.path),
                          _firebaseAuth.currentUser!.uid,
                        );
                      } else {
                        print('No image selected.');
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: const Color.fromARGB(
                        255, 249, 22, 89), // Color de fondo del botón
                    padding: const EdgeInsets.all(
                        16.0), // Espaciado interno del botón
                  ),
                  child: const Icon(
                    Icons.upload, // Icono del botón (puedes cambiarlo)
                    color: Colors.white, // Color del icono
                  ),
                ),
              ],
            ),
          ),
          //Nombre Usuario
          Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Nombre de usuario', // Etiqueta del campo
                  border: OutlineInputBorder(), // Borde del campo
                ),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                controller: _nombreUsuarioController,
                onChanged: (newValue) {
                  _nombreUsuarioController.text = newValue;
                },
              )),
          // Información del usuario
          Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Descripción de usuario', // Etiqueta del campo
                  border: OutlineInputBorder(), // Borde del campo
                ),
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
                controller: _descripcionUsuarioController,
                onChanged: (newValue) {
                  _descripcionUsuarioController.text = newValue;
                },
              )),
          //Edad
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.7,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Género', // Etiqueta del campo
                        border: OutlineInputBorder(), // Borde del campo
                      ),
                      style: const TextStyle(
                        fontSize: 12.0, // Tamaño de fuente del texto de entrada
                        fontWeight: FontWeight.bold,
                      ),
                      controller: _generoController,
                      onChanged: (newValue) {
                        _generoController.text = newValue;
                      },
                    ),
                  ),
                ), // Espacio entre los TextField
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Facultad', // Etiqueta del campo
                        border: OutlineInputBorder(), // Borde del campo
                      ),
                      style: const TextStyle(
                        fontSize: 12.0, // Tamaño de fuente del texto de entrada
                        fontWeight: FontWeight.bold,
                      ),
                      controller: _facultadController,
                      onChanged: (newValue) {
                        _facultadController.text = newValue;
                      },
                    ),
                  ),
                ), // Espacio entre los TextField
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Edad', // Etiqueta del campo
                        border: OutlineInputBorder(), // Borde del campo
                      ),
                      style: const TextStyle(
                        fontSize: 12.0, // Tamaño de fuente del texto de entrada
                        fontWeight: FontWeight.bold,
                      ),
                      controller: _edadController,
                      onChanged: (newValue) {
                        _edadController.text = newValue;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Intereses
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0,
                    10.0), // Aplicar espaciado solo hacia abajo
                child: Align(
                  alignment:
                      Alignment.centerLeft, // Alinear el texto a la izquierda
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
                runSpacing:
                    16.0, // Espaciado vertical entre filas de contenedores
                //children: containerWidgets,
                children: buildInterestWidgets(intereses),
              ),
            ]),
          ),
          // Spacer para empujar la opción de cierre de sesión hacia abajo
          const Spacer(),
          // Botón para cerrar sesión
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Acción para cerrar sesión
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.red, // Color de fondo del botón de cierre de sesión
                padding:
                    const EdgeInsets.all(16.0), // Espaciado interno del botón
              ),
              child: const Text(
                'Guardar Cambios',
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

  Widget buildProfileImage(BuildContext context) {
    Person person = Provider.of<PersonProvider>(context, listen: false)
        .getPersonById(_firebaseAuth.currentUser!.uid);

    return ProfileImage(profilePictureUrl: person.imagen.toString());
  }

  List<Widget> buildInterestWidgets(List<String> interests) {
    List<Widget> interestWidgets = [];

    for (String interest in interests) {
      bool isSelected = miIntereses.contains(interest);

      interestWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                miIntereses.remove(interest);
              } else {
                miIntereses.add(interest);
              }
            });
          },
          child: IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.red,
                  width: 2.0,
                ),
                color: isSelected ? Colors.black : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  interest,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return interestWidgets;
  }
}
