import 'package:flutter/material.dart';
import 'package:proyecto/screens/edit_profile_screen.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/myprofile';
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final List<String> intereses = ['Texto 1', 'Texto 2', 'Texto 3','Texto 1', 'Texto 2', 'Texto 3'];
  late List<Widget> containerWidgets;
  @override
  Widget build(BuildContext context) {
    containerWidgets = buildContainersWithBorder(intereses);
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
                const Text(
                  'Cristian Verduga',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10.0), // Espacio entre el texto y el botón
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar el botón
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
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child:
                Text(
                  'Soy un chico que ama la vida, me gustan las actividades que me sacan de mi zona de confort.',
                  style: TextStyle(fontSize: 16.0),
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
                child: const Center(
                  child: Text(
                    'Masculino',
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
                child: const Center(
                  child: Text(
                    'Facultad de Sistemas',
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
                child: const Center(
                  child: Text(
                    '21 años',
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
                 Navigator.pushNamed(context, EditUserProfileScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Color de fondo del botón de cierre de sesión
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
