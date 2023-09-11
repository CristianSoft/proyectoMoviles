import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/matches_provider.dart';
import 'package:proyecto/providers/login_provider.dart';
import 'package:proyecto/providers/person_provider.dart';
import 'package:proyecto/screens/match_screen.dart';
import 'package:proyecto/widgets/caja_usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SugerenciasWidget extends StatefulWidget {
  static const routeName = '/sugerencia';

  const SugerenciasWidget({super.key});

  @override
  State<SugerenciasWidget> createState() => _SugerenciasWidgetState();
}

class _SugerenciasWidgetState extends State<SugerenciasWidget> {
  int i = 0;
  String nombreMatch="";
  String imagen="";  
  
  @override
  void initState() {
    Provider.of<PersonProvider>(context, listen: false).initPersonList();
    Provider.of<PersonProvider>(context, listen: false).initSugerenciasList();
    Provider.of<MatchesProvider>(context, listen: false).obtenerLikes();
    Provider.of<MatchesProvider>(context, listen: false).obtenerMatches();
    super.initState();
  }

  void siguiente() {
    setState(() {
      if (i <
          Provider.of<PersonProvider>(context, listen: false)
                  .sugerenciasGetter
                  .length -
              1) {
        i++;
      } else {
        i = 0;
      }
    });
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
                'Sugerencias',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: Provider.of<PersonProvider>(context, listen: false)
                  .initSugerenciasList(),
              builder: (context, snapshot) {
                return CajaWidget(
                    usuario: Provider.of<PersonProvider>(context, listen: false)
                        .sugerenciasGetter[i]);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
                    child: ElevatedButton(
                      onPressed: () async {
                        // Obtener el correo de la sugerencia actual, reemplaza "i" con el índice correcto
                        final correoSugerencia =
                            await Provider.of<PersonProvider>(context,
                                    listen: false)
                                .sugerenciasGetter[i]
                                .email;
                        final id = await Provider.of<PersonProvider>(context,
                                listen: false)
                            .sugerenciasGetter[i]
                            .id;
                        // Agregar el correo a la lista de "likes"
                        await Provider.of<MatchesProvider>(context,
                                listen: false)
                            .addEmailToLike(correoSugerencia);

                        // Imprimir mensajes de depuración
                        print("//////Aún no son match");

                        // Obtener la lista de "likes"
                        await Provider.of<MatchesProvider>(context,
                                listen: false)
                            .obtenerLikes();
                        final esMatch = await Provider.of<MatchesProvider>(
                                context,
                                listen: false)
                            .sonMatch(correoSugerencia);
                        print("//////Entre si fueron match: $esMatch");

                        // Verificar si hay un match con el correo "a"
                        if (esMatch) {
                          print("//////Entre si fueron match");

                          // Agregar el correo a la lista de "match"
                          // ignore: use_build_context_synchronously
                          await Provider.of<MatchesProvider>(context,
                                  listen: false)
                              .addEmailToMatch(correoSugerencia,
                                  FirebaseAuth.instance.currentUser!.uid);
                          await Provider.of<MatchesProvider>(context,
                                  listen: false)
                              .addEmailToMatch(
                                  FirebaseAuth.instance.currentUser!.email, id);
                         
                          // ignore: use_build_context_synchronously
                         
                             setState(() {
                               nombreMatch = Provider.of<PersonProvider>(
                                  context,
                                  listen: false)
                              .sugerenciasGetter[i]
                              .name;
                          print(nombreMatch);
                          imagen = Provider.of<PersonProvider>(context,
                                  listen: false)
                              .sugerenciasGetter[i]
                              .imagen
                              .toString();
                             });
                            Navigator.pushNamed(context, MatchWidget.routeName,arguments: MatchWidget(nombreMatch: nombreMatch, imageUrl1: imagen, imageUrl2: "a"));
                          
                          
                        }

                        // Llamar a la función siguiente
                        siguiente();
                      },

                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          backgroundColor:
                              const Color.fromARGB(255, 249, 22, 89)),
                      child: const Icon(
                        Icons.favorite,
                        size: 40,
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            siguiente();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(20),
                            backgroundColor:
                                const Color.fromARGB(255, 249, 22, 89)),
                        child: const Icon(
                          Icons.close,
                          size: 40,
                        )))
              ],
            )
          ],
        ),
      ),
    );
  }
}
