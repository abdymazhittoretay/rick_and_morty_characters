import 'package:flutter/material.dart';
import 'package:rick_and_morty_characters/models/character_model.dart';
import 'package:rick_and_morty_characters/widgets/custom_listtile.dart';

class MyListviewWidget extends StatelessWidget {
  const MyListviewWidget({super.key, required this.characters});

  final List<CharacterModel> characters;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final CharacterModel character = characters[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: CustomListTile(character: character)
          ),
        );
      },
    );
  }
}
