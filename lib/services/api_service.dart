import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_characters/models/character_model.dart';

final ValueNotifier<ApiService> apiService = ValueNotifier(ApiService());

class ApiService {
  final String _baseUrl = 'https://rickandmortyapi.com/api';
  final _cacheBox = Hive.box('cacheBox');

  Future<List<CharacterModel>> fetchCharacters(int page) async {
    final String cacheKey = 'page_$page';

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/character?page=$page'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List results = data['results'];

        final List<CharacterModel> characters = results
            .map((e) => CharacterModel.fromJson(e))
            .toList();

        await _cacheBox.put(
          cacheKey,
          characters.map((c) => c.toJson()).toList(),
        );

        return characters;
      } else {
        throw Exception('Failed to load characters');
      }
    } catch (e) {
      final cachedData = _cacheBox.get(cacheKey);

      if (cachedData != null) {
        final List<CharacterModel> cachedCharacters = (cachedData as List)
            .map(
              (item) =>
                  CharacterModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
        debugPrint('Loaded from cache: $cacheKey');
        return cachedCharacters;
      } else {
        rethrow;
      }
    }
  }

  Future<List<CharacterModel>> fetchCharacterByName(
    String name,
    int page,
  ) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/character?name=$name&page=$page'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List results = data['results'];

      final List<CharacterModel> characters = results
          .map((e) => CharacterModel.fromJson(e))
          .toList();
      return characters;
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
