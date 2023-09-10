import 'package:flutter/material.dart';

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
  late List<String> miIntereses;
  late List<Widget> containerWidgets;
  TextEditingController _nombreUsuarioController = TextEditingController(text: 'Cristian Verduga');
  TextEditingController _descripcionUsuarioController = TextEditingController(
    text: 'Soy un chico que ama la vida, me gustan las actividades que me sacan de mi zona de confort.');
  TextEditingController _generoController = TextEditingController(text: 'Masculino');
  TextEditingController _facultadController = TextEditingController(text: 'Facultad de Sistemas');
  TextEditingController _edadController = TextEditingController(text: '21 años');
  @override
  Widget build(BuildContext context) {
    containerWidgets = buildContainersWithBorder(intereses);
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
              children: <Widget> [
                Container(
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
                const SizedBox(width: 10.0), // Espacio entre el texto y el botón
                ElevatedButton(
                  onPressed: () {
                    // Escoger foto desde la galeria
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), 
                    backgroundColor: const Color.fromARGB(255, 249, 22, 89), // Color de fondo del botón
                    padding: const EdgeInsets.all(16.0), // Espaciado interno del botón
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
            )
          ),
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
            )
          ),
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
                ),// Espacio entre los TextField
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
                // Acción para cerrar sesión
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Color de fondo del botón de cierre de sesión
                padding: const EdgeInsets.all(16.0), // Espaciado interno del botón
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