import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemons {
  final PokemonRepository repository;

  GetPokemons(this.repository);
  Future<List<Pokemon>> call({required int offset}) async {
    return await repository.getPokemons(offset: offset);
  }
}
