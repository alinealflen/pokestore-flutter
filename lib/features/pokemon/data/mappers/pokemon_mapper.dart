import '../../domain/entities/pokemon.dart';
import '../models/pokemon_model.dart';

class PokemonMapper {
  static Pokemon toEntity(PokemonModel model) {
    return Pokemon(
      id: model.id,
      name: model.name,
      image: model.image,
      price: model.price,
    );
  }
}
