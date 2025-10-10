import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_characters/models/character_model.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.character,
  });

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: CachedNetworkImage(
        imageUrl: character.image,
        width: 100,
        height: 120,
        fit: BoxFit.cover,
        placeholder: (context, url) => const SizedBox(
          width: 100,
          height: 120,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.black,
            ),
          ),
        ),
        errorWidget: (context, url, error) => const SizedBox(
          width: 100,
          height: 120,
          child: Center(
            child: Icon(Icons.image_not_supported_outlined, size: 60),
          ),
        ),
      ),
    );
  }
}
