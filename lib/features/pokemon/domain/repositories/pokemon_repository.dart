import '../entities/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemons({required int offset});

  Future<List<String>> getPokemonNames();
}
