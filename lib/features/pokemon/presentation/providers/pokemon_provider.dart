import 'package:flutter/material.dart';
import 'package:pokestore/features/pokemon/domain/usecases/get_pokemons_names.dart';
import 'dart:collection';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_pokemons.dart';
import '../../domain/usecases/get_pokemon_by_name.dart';

class PokemonProvider extends ChangeNotifier {
  final GetPokemons getPokemons;
  final GetPokemonNames getPokemonNames;
  final GetPokemonByName getPokemonByName;

  PokemonProvider(
    this.getPokemons,
    this.getPokemonNames,
    this.getPokemonByName,
  );

  final List<Pokemon> _pokemons = [];
  final List<String> _pokemonNames = [];

  UnmodifiableListView<Pokemon> get pokemons => UnmodifiableListView(_pokemons);
  UnmodifiableListView<String> get pokemonNames =>
      UnmodifiableListView(_pokemonNames);

  bool _isLoading = false;

  String? _errorMessage;

  int _offset = 0;

  bool _hasMore = true;

  bool _isLoadingMore = false;

  String _search = '';

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  String get search => _search;

  bool get hasMore => _hasMore;

  bool get isLoadingMore => _isLoadingMore;

  Future<void> fetchPokemons() async {
    _isLoading = true;
    _errorMessage = null;
    _offset = 0;
    _hasMore = true;

    notifyListeners();

    try {
      final result = await getPokemons(offset: _offset);

      _pokemons
        ..clear()
        ..addAll(result);

      _offset += 20;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;

    notifyListeners();
  }

  Future<void> loadMorePokemons() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;

    notifyListeners();

    try {
      final result = await getPokemons(offset: _offset);

      if (result.isEmpty) {
        _hasMore = false;
      } else {
        _pokemons.addAll(result);
        _offset += 20;
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoadingMore = false;

    notifyListeners();
  }

  void setSearch(String value) {
    _search = value.toLowerCase();

    notifyListeners();
  }

  void clearSearch() {
    _search = '';

    notifyListeners();
  }

  Future<void> loadPokemonNames() async {
    try {
      final names = await getPokemonNames();
      _pokemonNames
        ..clear()
        ..addAll(names);

      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();

      notifyListeners();
    }
  }

  List<String> get filteredPokemonNames {
    if (_search.isEmpty) {
      return [];
    }

    return _pokemonNames
        .where((name) => name.toLowerCase().contains(_search))
        .take(20)
        .toList();
  }

  Future<Pokemon> searchPokemon(String name) async {
    return await getPokemonByName(name);
  }
}
