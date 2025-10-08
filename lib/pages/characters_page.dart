import 'package:flutter/material.dart';
import 'package:rick_and_morty_characters/models/character_model.dart';
import 'package:rick_and_morty_characters/services/api_service.dart';
import 'package:rick_and_morty_characters/widgets/my_listview_widget.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Characters Page')),
      body: FutureBuilder(
        future: apiService.value.fetchCharacters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black87),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No data received."));
          }

          final List<CharacterModel> characters = snapshot.data!;

          if (characters.isEmpty) {
            return const Center(child: Text("Characters list is empty!"));
          }

          return MyListviewWidget(characters: characters);
        },
      ),
    );
  }
}
