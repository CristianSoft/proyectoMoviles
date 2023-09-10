import 'package:flutter/material.dart';

class InterfazInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
            width: double.infinity,
            color: const Color(0xFFF91659),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'PoliMatch',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 48.0,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      'lib/images/logoLogin.png', // Ruta de la imagen del logotipo
                      width: 200.0, // Ancho de la imagen
                      height: 200.0, // Alto de la imagen
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
