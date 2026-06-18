import '../repositories/pokemon_repository.dart';

class GetPokemonNames {
  final PokemonRepository repository;

  GetPokemonNames(this.repository);

  Future<List<String>> call() async {
    return await repository.getPokemonNames();
  }
}
