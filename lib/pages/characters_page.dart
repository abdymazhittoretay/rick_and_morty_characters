import 'package:flutter/material.dart';
import 'package:rick_and_morty_characters/models/character_model.dart';
import 'package:rick_and_morty_characters/services/api_service.dart';
import 'package:rick_and_morty_characters/widgets/my_listview_widgets/my_listview_widget.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final List<CharacterModel> _characters = [];

  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
  }

  Future<void> _fetchCharacters() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      final newCharacters = await apiService.value.fetchCharacters(_page);

      setState(() {
        if (newCharacters.isEmpty) {
          _hasMore = false;
        } else {
          _page++;
          _characters.addAll(newCharacters);
        }
      });
    } catch (e) {
      debugPrint("Error: $e");
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person),
            SizedBox(width: 8.0),
            Text("Characters"),
          ],
        ),
        centerTitle: true,
      ),
      body: _characters.isEmpty && _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.black87),
            )
          : _characters.isEmpty
          ? const Center(child: Text("Characters list is empty!"))
          : NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent - 200 &&
                    !_isLoading &&
                    _hasMore) {
                  _fetchCharacters();
                }
                return false;
              },
              child: MyListviewWidget(characters: _characters, isLoading: _isLoading, hasMore: _hasMore),
            ),
    );
  }
}
