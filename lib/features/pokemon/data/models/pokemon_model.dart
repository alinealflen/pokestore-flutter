class PokemonModel {
  final int id;
  final String name;
  final String image;
  final double price;

  PokemonModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      image: json['sprites']['front_default'] ?? '',
      price: (json['id'] * 3.5) + 19.9,
    );
  }
}
