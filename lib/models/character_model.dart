class CharacterModel {
    final int id;
    final String name;
    final String status;
    final String species;
    final String gender;
    final String location;
    final String image;

    CharacterModel({
        required this.id,
        required this.name,
        required this.status,
        required this.species,
        required this.gender,
        required this.location,
        required this.image,
    });

    CharacterModel copyWith({
        int? id,
        String? name,
        String? status,
        String? species,
        String? gender,
        String? location,
        String? image,
    }) => 
        CharacterModel(
            id: id ?? this.id,
            name: name ?? this.name,
            status: status ?? this.status,
            species: species ?? this.species,
            gender: gender ?? this.gender,
            location: location ?? this.location,
            image: image ?? this.image,
        );

    factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        gender: json["gender"],
        location: json["location"]["name"],
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