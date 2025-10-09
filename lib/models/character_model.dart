import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'character_model.g.dart';

@HiveType(typeId: 3)
class CharacterModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String status;
  @HiveField(3)
  final String species;
  @HiveField(4)
  final String gender;
  @HiveField(5)
  final String location;
  @HiveField(6)
  final String image;
  @HiveField(7)
  final DateTime? createdAt;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.location,
    required this.image,
    this.createdAt,
  });

  CharacterModel copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? gender,
    String? location,
    String? image,
    DateTime? createdAt,
  }) => CharacterModel(
    id: id ?? this.id,
    name: name ?? this.name,
    status: status ?? this.status,
    species: species ?? this.species,
    gender: gender ?? this.gender,
    location: location ?? this.location,
    image: image ?? this.image,
    createdAt: createdAt ?? this.createdAt,
  );

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    species: json["species"],
    gender: json["gender"],
    location: json["location"] is Map
        ? json["location"]["name"]
        : json["location"]?.toString() ?? "Unknown",
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "species": species,
    "gender": gender,
    "location": location,
    "image": image,
  };
}

extension CharacterFormatting on CharacterModel {
  String get formattedStatus => status.isNotEmpty
      ? '${status[0].toUpperCase()}${status.substring(1).toLowerCase()}'
      : 'Unknown';

  String get formattedGender => gender.isNotEmpty
      ? '${gender[0].toUpperCase()}${gender.substring(1).toLowerCase()}'
      : 'Unknown';

  IconData get genderIcon => switch (gender.toLowerCase()) {
    'male' => Icons.male,
    'female' => Icons.female,
    _ => Icons.person_outline,
  };

  String get formattedLocation => location.isNotEmpty
      ? '${location[0].toUpperCase()}${location.substring(1).toLowerCase()}'
      : 'Unknown';
}
