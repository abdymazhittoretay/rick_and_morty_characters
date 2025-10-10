import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_characters/models/character_model.dart';
import 'package:rick_and_morty_characters/services/api_service.dart';
import 'package:rick_and_morty_characters/widgets/search_page_widgets/search_info_widget.dart';
import 'package:rick_and_morty_characters/widgets/search_page_widgets/search_textfield_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final List<CharacterModel> _characters = [];

  int _page = 1;
  bool _isLoading = false;
  bool _hasResults = true;

  final Box _box = Hive.box('searchCacheBox');

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  void _startNewSearch() {
    setState(() {
      _characters.clear();
      _page = 1;
      _hasResults = true;
      _isLoading = false;
    });
    _performSearch(_controller.text);
    if (_controller.text.isNotEmpty &&
        !_box.values.contains(_controller.text)) {
      _box.add(_controller.text);
    }
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty || _isLoading || !_hasResults) return;
    setState(() => _isLoading = true);

    try {
      final newCharacters = await apiService.value.fetchCharacterByName(
        query,
        _page,
      );

      setState(() {
        if (newCharacters.isEmpty) {
          _hasResults = false;
        } else {
          _page++;
          _characters.addAll(newCharacters);
        }
      });
    } catch (e) {
      setState(() {
        _hasResults = false;
      });
      debugPrint("Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.search),
            SizedBox(width: 8.0),
            Text("Search Characters"),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SearchTextFieldWidget(
            controller: _controller,
            startNewSearch: _startNewSearch,
            clearSearch: () {
              _controller.clear();
              setState(() {
                _characters.clear();
                _page = 1;
                _hasResults = true;
                _isLoading = false;
              });
            },
          ),
          SearchInfoWidget(
            isLoading: _isLoading,
            hasResults: _hasResults,
            characters: _characters,
            controller: _controller,
            box: _box,
            performSearch: _performSearch,
            startNewSearch: _startNewSearch,
          ),
        ],
      ),
    );
  }
}
