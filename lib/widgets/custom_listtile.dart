import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_characters/models/character_model.dart';

class CustomListTile extends StatelessWidget {
  final CharacterModel character;

  const CustomListTile({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<CharacterModel>('favoritesBox');
    final bool isSaved = box.values.any((c) => c.id == character.id);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
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
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${character.name}, ${character.species}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 16,
                    color: character.status == 'Alive'
                        ? Colors.green
                        : (character.status == 'Dead'
                              ? Colors.red
                              : Colors.grey),
                  ),
                  const SizedBox(width: 6),
                  Text('Status: ${character.formattedStatus}'),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(character.genderIcon, size: 16, color: Colors.black54),
                  const SizedBox(width: 6),
                  Text("Gender: ${character.formattedGender}"),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Location: ${character.location}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          iconSize: 28.0,
          onPressed: () {
            if (isSaved) {
              box.delete(character.id);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.black87,
                    content: Center(
                      child: Text("Removed from Favorites", style: TextStyle()),
                    ),
                    duration: Duration(seconds: 1),
                  ),
                );
            } else {
              box.put(character.id, character);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.black87,
                    content: Center(child: Text("Added to Favorites")),
                    duration: Duration(seconds: 1),
                  ),
                );
            }
          },
          icon: Icon(isSaved ? Icons.star : Icons.star_border),
        ),
      ],
    );
  }
}
