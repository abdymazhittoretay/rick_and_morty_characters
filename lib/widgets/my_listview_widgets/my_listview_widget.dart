import 'package:flutter/material.dart';
import 'package:rick_and_morty_characters/models/character_model.dart';
import 'package:rick_and_morty_characters/widgets/my_listview_widgets/custom_listtile.dart';

class MyListviewWidget extends StatelessWidget {
  final List<CharacterModel> characters;
  final bool? isLoading;
  final bool? hasMore;

  const MyListviewWidget({
    super.key,
    required this.characters,
    this.isLoading,
    this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    final loading = isLoading ?? false;
    final more = hasMore ?? false;

    return ListView.builder(
      itemCount: characters.length + ((loading && more) ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < characters.length) {
          final character = characters[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CustomListTile(character: character),
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: CircularProgressIndicator(color: Colors.black87),
            ),
          );
        }
      },
    );
  }
}
