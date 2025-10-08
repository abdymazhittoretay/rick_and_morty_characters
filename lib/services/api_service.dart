import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_characters/models/character_model.dart';

final ValueNotifier<ApiService> apiService = ValueNotifier(ApiService());

class ApiService {
  final String _baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<CharacterModel>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$_baseUrl/character'));
    
    if (response.statusCode == 200) {
      final List results = json.decode(response.body)['results'];
      return results.map((json) => CharacterModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<List<CharacterModel>> fetchCharacterByName(String name) async {
    final response = await http.get(Uri.parse('$_baseUrl/character?name=$name'));
    
    if (response.statusCode == 200) {
      final List results = json.decode(response.body)['results'];
      return results.map((json) => CharacterModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}