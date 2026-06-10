class PokemonModel {
  final int id;
  final String name;
  final String image;

  PokemonModel({required this.id, required this.name, required this.image});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      image: json['sprites']['front_default'],
    );
  }
}
