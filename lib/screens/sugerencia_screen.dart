import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugerencias/Models/usuario.dart';
import 'package:sugerencias/provider/usuario_provider.dart';
import 'package:sugerencias/widgets/caja_usuario.dart';

class SugerenciasWidget extends StatefulWidget {
  const SugerenciasWidget({super.key});

  @override
  State<SugerenciasWidget> createState() => _SugerenciasWidgetState();
}

class _SugerenciasWidgetState extends State<SugerenciasWidget> {
  int i=0;
  @override
  void initState() {
    Provider.of<UsuarioProvider>(context,listen: false).initalizeUsuarios();
    super.initState();
  }

  void siguiente(){
    if (i<Provider.of<UsuarioProvider>(context,listen: false).usuariosGetter.length-1) {
      i++;
    }else{
      i=0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CajaWidget(usuario: Provider.of<UsuarioProvider>(context,listen: false).usuariosGetter[i]),
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
                      backgroundColor: const Color.fromARGB(255, 249, 22, 89)),
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
    );
  }
}
