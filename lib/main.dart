import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokestore/features/pokemon/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokestore/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokestore/features/pokemon/domain/usecases/get_pokemon_by_name.dart';
import 'package:pokestore/features/pokemon/domain/usecases/get_pokemons.dart';
import 'package:pokestore/features/pokemon/presentation/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';
import 'features/pokemon/presentation/pages/pokemon_page.dart';
import 'package:pokestore/features/pokemon/domain/usecases/get_pokemons_names.dart';

void main() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://pokeapi.co/api/v2',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  final dataSource = PokemonRemoteDataSource(dio);
  final repository = PokemonRepositoryImpl(dataSource);

  final getPokemons = GetPokemons(repository);
  final getPokemonsNames = GetPokemonNames(repository);
  final getPokemonByName = GetPokemonByName(repository);

  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          PokemonProvider(getPokemons, getPokemonsNames, getPokemonByName)
            ..fetchPokemons()
            ..loadPokemonNames(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokestore',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const PokemonPage(),
    );
  }
}
