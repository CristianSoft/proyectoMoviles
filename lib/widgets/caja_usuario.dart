import 'package:flutter/material.dart';
import 'package:proyecto/dtos/person_model.dart';

class CajaWidget extends StatefulWidget {
  final Person usuario;
  const CajaWidget({super.key, required this.usuario});

 

  @override
  State<CajaWidget> createState() => _CajaWidgetState();
}

class _CajaWidgetState extends State<CajaWidget> {
   Widget loadIcon(String imagen) {
    if (imagen == '') {
      return const Icon(Icons.person,size:  300,);
    } else {
      return Image.network(
        imagen,
        fit: BoxFit.cover,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: 300,
        height: 450,
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 249, 22, 89), width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child:loadIcon(widget.usuario.imagen!)
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                "${widget.usuario.name}, ${widget.usuario.edad}",
                style:
                    const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text(
                "Facultad: ${widget.usuario.faculty}",
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text(
                "Genero: ${widget.usuario.genero}",
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.normal),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: SingleChildScrollView(
                  child: Text(
                    "Descripción: ${widget.usuario.descripcion}",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
