import 'package:pokestore/features/pokemon/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokestore/features/pokemon/data/mappers/pokemon_mapper.dart';
import 'package:pokestore/features/pokemon/data/models/pokemon_model.dart';
import 'package:pokestore/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokestore/features/pokemon/domain/entities/pokemon.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource dataSource;

  PokemonRepositoryImpl(this.dataSource);

  @override
  Future<List<Pokemon>> getPokemons() async {
    final results = await dataSource.getPokemons();

    List<Pokemon> pokemons = [];

    for (final item in results) {
      final detail = await dataSource.getPokemonDetail(item['url']);

      final model = PokemonModel.fromJson(detail);

      pokemons.add(PokemonMapper.toEntity(model));
    }

    return pokemons;
  }
}
