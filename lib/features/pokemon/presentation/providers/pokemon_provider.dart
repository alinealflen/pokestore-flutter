import 'package:flutter/material.dart';
import 'dart:collection';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_pokemons.dart';

class PokemonProvider extends ChangeNotifier {
  final GetPokemons getPokemons;

  PokemonProvider(this.getPokemons);

  final List<Pokemon> _pokemons = [];

  UnmodifiableListView<Pokemon> get pokemons => UnmodifiableListView(_pokemons);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  int _offset = 0;

  bool _hasMore = true;

  bool _isLoadingMore = false;

  String? get errorMessage => _errorMessage;

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
}
