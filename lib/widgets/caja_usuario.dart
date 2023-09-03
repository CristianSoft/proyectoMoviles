import 'package:flutter/material.dart';
import 'package:proyecto/dtos/usuario.dart';

class CajaWidget extends StatefulWidget {
  final Usuario usuario;
  const CajaWidget({super.key, required this.usuario});

  @override
  State<CajaWidget> createState() => _CajaWidgetState();
}

class _CajaWidgetState extends State<CajaWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: 300,
        height: 500,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255,249, 22, 89), width: 2),
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
              child: Image.network(
                widget.usuario.imagen,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "${widget.usuario.nombre} ${widget.usuario.edad}",
                style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Text(
                    widget.usuario.descripcion,
                    style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.normal
                    ),
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
