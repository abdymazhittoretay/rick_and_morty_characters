import 'package:flutter/material.dart';
import 'package:rick_and_morty_characters/models/character_model.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
    required this.character,
  });

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
