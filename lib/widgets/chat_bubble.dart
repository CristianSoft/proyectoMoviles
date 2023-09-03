import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/dtos/message.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final Color color;
  final String type;
  const ChatBubble(
      {super.key,
      required this.message,
      required this.color,
      required this.type});

  @override
  Widget build(BuildContext context) {
    //si es texto renderiza texto sino imagen
    return Container(
      padding: const EdgeInsets.all(12),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), color: color),
      child: type == 'text'
          ? Text(
              message,
              style: TextStyle(fontSize: 16),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                  width: 100,
                  height: 100,
                  imageUrl: message,
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.image, size: 70)),
            ),
    );
  }
}
