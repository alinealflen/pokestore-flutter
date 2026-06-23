import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonByName {
  final PokemonRepository repository;

  GetPokemonByName(this.repository);

  Future<Pokemon> call(String name) async {
    return await repository.getPokemonByName(name);
  }
}
