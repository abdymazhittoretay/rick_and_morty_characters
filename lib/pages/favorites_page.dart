import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_characters/models/character_model.dart';
import 'package:rick_and_morty_characters/widgets/my_listview_widget.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<CharacterModel>('favBox');
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.star), SizedBox(width: 8.0), Text("Favorites")],
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<CharacterModel> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No saved characters yet."));
          }
          final List<CharacterModel> characters = box.values.where((c) => c.createdAt != null).toList()
            ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));;

          return MyListviewWidget(characters: characters);
        },
      ),
    );
  }
}
