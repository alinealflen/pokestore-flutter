import 'package:pokestore/features/pokemon/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokestore/features/pokemon/data/mappers/pokemon_mapper.dart';
import 'package:pokestore/features/pokemon/data/models/pokemon_model.dart';
import 'package:pokestore/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokestore/features/pokemon/domain/entities/pokemon.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource dataSource;

  PokemonRepositoryImpl(this.dataSource);

  @override
  Future<List<Pokemon>> getPokemons({required int offset}) async {
    final results = await dataSource.getPokemons(offset: offset);

    List<Pokemon> pokemons = [];

    for (final item in results) {
      final detail = await dataSource.getPokemonDetail(item['url']);

      final model = PokemonModel.fromJson(detail);

      pokemons.add(PokemonMapper.toEntity(model));
    }

    return pokemons;
  }

  @override
  Future<List<String>> getPokemonNames() async {
    final results = await dataSource.getPokemonNames();

    return results.map<String>((pokemon) => pokemon['name'] as String).toList();
  }
}
