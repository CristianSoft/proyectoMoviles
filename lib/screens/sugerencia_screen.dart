import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/person_provider.dart';
import 'package:proyecto/widgets/caja_usuario.dart';

class SugerenciasWidget extends StatefulWidget {
  static const routeName = '/sugerencia';
  const SugerenciasWidget({super.key});

  @override
  State<SugerenciasWidget> createState() => _SugerenciasWidgetState();
}

class _SugerenciasWidgetState extends State<SugerenciasWidget> {
  int i = 0;
  @override
  void initState() {
    Provider.of<PersonProvider>(context, listen: false).initPersonList();
    super.initState();
  }

  void siguiente() {
    if (i <
        Provider.of<PersonProvider>(context, listen: false)
                .usuariosGetter
                .length -
            1) {
      i++;
    } else {
      i = 0;
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
      body: Column(
        children: [
          FutureBuilder(
            future: Provider.of<PersonProvider>(context, listen: false)
                .initPersonList(),
            builder: (context, snapshot) {
              return CajaWidget(
                  usuario: Provider.of<PersonProvider>(context, listen: false)
                      .usuariosGetter[i]);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
                  child: ElevatedButton(
                    onPressed: () {},
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
    );
  }
}
