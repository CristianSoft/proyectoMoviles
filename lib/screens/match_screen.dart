import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/main.dart';

class MatchWidget extends StatefulWidget {
  static const routeName = '/match';
  final String nombreMatch;
  final String imageUrl1;
  final String imageUrl2;

  const MatchWidget({
    Key? key,
    required this.nombreMatch,
    required this.imageUrl1,
    required this.imageUrl2,
  }) : super(key: key);

  @override
  State<MatchWidget> createState() => _MatchWidgetState();
}

class _MatchWidgetState extends State<MatchWidget> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor:
              Colors.black.withOpacity(0.5), // Fondo negro transparente
          body: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                    padding: EdgeInsets.fromLTRB(0,100,0,5),
                    child: Text(
                      "¡Match!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0,5,0,100),
                    child: Text(
                      "Tu y ${widget.nombreMatch} hicieron match",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 145,
                      height: 145,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 249, 22, 89),
                            width: 2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: loadIcon(widget.imageUrl1)
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 145,
                      height: 145,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 249, 22, 89),
                            width: 2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: loadIcon(widget.imageUrl2)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MainWidget.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25.0), // Bordes redondeados
                      ),
                       // Color del texto blanco
                      side: const BorderSide(
                        color: Colors.pink, // Borde de color rosa
                        width: 2.0,
                        // Ancho del borde
                      ),
                    ),
                    child: const Text('Seguir deslizando',style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

Widget loadIcon(String imagen) {
  if (imagen == '') {
    return const Icon(Icons.person, size: 300);
  } else {
    return AspectRatio(
      aspectRatio: 1.0, // Esto mantiene la relación de aspecto 1:1
      child: FittedBox(
        fit: BoxFit.cover,
        child: Image.network(
          imagen,
        ),
      ),
    );
  }
}
