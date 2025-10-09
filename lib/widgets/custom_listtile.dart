import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_characters/models/character_model.dart';
import 'package:rick_and_morty_characters/widgets/favorite_widget.dart';
import 'package:rick_and_morty_characters/widgets/image_widget.dart';
import 'package:rick_and_morty_characters/widgets/info_widget.dart';

class CustomListTile extends StatelessWidget {
  final CharacterModel character;

  const CustomListTile({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<CharacterModel>('favBox');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageWidget(character: character),
        const SizedBox(width: 12),
        InfoWidget(character: character),
        FavoriteWidget(box: box, character: character),
      ],
    );
  }
}
