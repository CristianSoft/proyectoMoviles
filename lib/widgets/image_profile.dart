import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/dtos/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileImage extends StatelessWidget {
  final String profilePictureUrl;

  ProfileImage({super.key, required this.profilePictureUrl});

  @override
  Widget build(BuildContext context) {
    //si es texto renderiza texto sino imagen
    return Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color.fromARGB(255, 249, 22, 89),
          width: 4.0,
        ),
      ),
      child: profilePictureUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                  width: 100,
                  height: 100,
                  imageUrl: profilePictureUrl,
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.warning, size: 70)),
            )
          : Image.asset('lib/images/usuarioGenerico.png'),
    );
  }
}
