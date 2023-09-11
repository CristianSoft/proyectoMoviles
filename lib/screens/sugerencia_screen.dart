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
  String? nombreMatch;
  String? imagen1;
  String? imagen2;

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  Future<void> _initializeData() async {
    await Provider.of<PersonProvider>(context, listen: false).initPersonList();
    await Provider.of<PersonProvider>(context, listen: false)
        .initSugerenciasList();
    await Provider.of<MatchesProvider>(context, listen: false).obtenerLikes();
    await Provider.of<MatchesProvider>(context, listen: false).obtenerMatches();
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

  Future<void> _handleLike() async {
    final sugerenciasProvider =
        Provider.of<PersonProvider>(context, listen: false);
    final matchesProvider =
        Provider.of<MatchesProvider>(context, listen: false);

    final correoSugerencia = sugerenciasProvider.sugerenciasGetter[i].email;
    final id = sugerenciasProvider.sugerenciasGetter[i].id;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await matchesProvider.addEmailToLike(correoSugerencia);
      await matchesProvider.obtenerLikes();

      final esMatch = await matchesProvider.sonMatch(correoSugerencia);

      if (esMatch) {
        await matchesProvider.addEmailToMatch(
          correoSugerencia,
          FirebaseAuth.instance.currentUser!.uid,
        );
        await matchesProvider.addEmailToMatch(
          FirebaseAuth.instance.currentUser!.email,
          id,
        );

        setState(() {
          nombreMatch = sugerenciasProvider.sugerenciasGetter[i].name;
          imagen1 = sugerenciasProvider.sugerenciasGetter[i].imagen;
          imagen2 = sugerenciasProvider.getPersonById(_auth.currentUser!.uid).imagen;
          print("nombreMatch: $nombreMatch");
          print("imagen: $imagen1");
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MatchWidget(
              nombreMatch: nombreMatch!,
              imageUrl1: imagen1!,
              imageUrl2: imagen2!,
            ),
          ),
        );

        print("nombreMatch: $nombreMatch");
        print("imagen: $imagen1");
      }
      siguiente();
    } catch (e) {
      // Manejar errores adecuadamente, como mostrar un mensaje al usuario
      print("Error al manejar el 'Me gusta': $e");
    }
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
                      onPressed: _handleLike,
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
