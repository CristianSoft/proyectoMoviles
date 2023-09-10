import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MatchWidget extends StatefulWidget {
  static const routeName = '/match';
  const MatchWidget({super.key});

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
                const Padding(
                    padding: EdgeInsets.fromLTRB(0,5,0,100),
                    child: Text(
                      "Tu y Juan hicieron match",
                      style: TextStyle(
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
                        child: Image.network(
                          "https://scontent.fuio5-1.fna.fbcdn.net/v/t31.18172-8/22861746_1480120132057569_5859221830910884783_o.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeHKRdO7cUXDcW0n8TZ1Iv8jjntIhFT2XUGOe0iEVPZdQdm5F5xfCWCHB0s-Htyr0UtmiNCK7PZ8YGeO4hdwIf6-&_nc_ohc=_N02MM4EoNwAX9ib3lf&_nc_ht=scontent.fuio5-1.fna&oh=00_AfAOfqi4MGE_eolLEFQd122rg5KvRSRBdGItbWD9_WtU_Q&oe=6517AC28",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
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
                        child: Image.network(
                          "https://scontent.fuio5-1.fna.fbcdn.net/v/t31.18172-8/22861746_1480120132057569_5859221830910884783_o.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeHKRdO7cUXDcW0n8TZ1Iv8jjntIhFT2XUGOe0iEVPZdQdm5F5xfCWCHB0s-Htyr0UtmiNCK7PZ8YGeO4hdwIf6-&_nc_ohc=_N02MM4EoNwAX9ib3lf&_nc_ht=scontent.fuio5-1.fna&oh=00_AfAOfqi4MGE_eolLEFQd122rg5KvRSRBdGItbWD9_WtU_Q&oe=6517AC28",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción cuando se presiona el botón
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink, // Color de fondo rosa
                      onPrimary: Colors.white, // Color del texto blanco
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25.0), // Bordes redondeados
                      ),
                    ),
                    child: Text('Enviar mensaje',style: TextStyle(fontSize: 20),),
                  ),
                ),
                Container(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción cuando se presiona el botón
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // Fondo transparente
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25.0), // Bordes redondeados
                      ),
                       // Color del texto blanco
                      side: BorderSide(
                        color: Colors.pink, // Borde de color rosa
                        width: 2.0,
                        // Ancho del borde
                      ),
                    ),
                    child: Text('Seguir deslizando',style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
