import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_characters/models/character_model.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    super.key,
    required this.box,
    required this.character,
  });

  final Box<CharacterModel> box;
  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, value, child) {
        final bool isSaved = box.values.any((c) => c.id == character.id);
        return IconButton(
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
                      child: Text(
                        "Removed from Favorites",
                        style: TextStyle(),
                      ),
                    ),
                    duration: Duration(seconds: 1),
                  ),
                );
            } else {
              box.put(
                character.id,
                character.copyWith(createdAt: DateTime.now()),
              );
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
        );
      },
    );
  }
}
