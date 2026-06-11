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

  String? get errorMessage => _errorMessage;

  Future<void> fetchPokemons() async {
    _isLoading = true;
    _errorMessage = null;

    notifyListeners();

    try {
      final result = await getPokemons();

      _pokemons
        ..clear()
        ..addAll(result);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;

    notifyListeners();
  }
}
