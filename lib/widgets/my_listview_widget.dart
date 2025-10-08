import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_characters/models/character_model.dart';

class MyListviewWidget extends StatelessWidget {
  const MyListviewWidget({super.key, required this.characters});

  final List<CharacterModel> characters;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final CharacterModel character = characters[index];
        final status = character.status.isNotEmpty
            ? '${character.status[0].toUpperCase()}${character.status.substring(1).toLowerCase()}'
            : 'Unknown';
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
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
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 60,
                        ),
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
                            size: 12,
                            color: character.status == 'Alive'
                                ? Colors.green
                                : (character.status == 'Dead'
                                      ? Colors.red
                                      : Colors.grey),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Status: $status',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
