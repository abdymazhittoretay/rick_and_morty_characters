import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_characters/models/character_model.dart';
import 'package:rick_and_morty_characters/widgets/my_listview_widgets/my_listview_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool sortByTime = true;
  bool ascending = false;

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<CharacterModel>('favBox');

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.star),
            SizedBox(width: 8.0),
            Text("Favorites"),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              '${sortByTime ? "Time" : "Name"} ${ascending ? "asc" : "desc"}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          PopupMenuButton<bool>(
            icon: const Icon(Icons.swap_vert),
            tooltip: 'Change order',
            onSelected: (value) {
              setState(() => ascending = value);
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: true, child: Text('Ascending')),
              PopupMenuItem(value: false, child: Text('Descending')),
            ],
          ),
          PopupMenuButton<bool>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort options',
            onSelected: (value) {
              setState(() => sortByTime = value);
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: true, child: Text('Sort by time')),
              PopupMenuItem(value: false, child: Text('Sort by name')),
            ],
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<CharacterModel> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No saved characters yet."));
          }

          final List<CharacterModel> characters =
              box.values.where((c) => c.createdAt != null).toList()
                ..sort((a, b) {
                  int result;
                  if (sortByTime) {
                    result = a.createdAt!.compareTo(b.createdAt!);
                  } else {
                    result = a.name.compareTo(b.name);
                  }
                  return ascending ? result : -result;
                });

          return MyListviewWidget(characters: characters);
        },
      ),
    );
  }
}
