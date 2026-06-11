import 'package:flutter/material.dart';
import 'package:pokestore/features/pokemon/presentation/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';

import '../providers/pokemon_provider.dart';

class PokemonPage extends StatelessWidget {
  const PokemonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PokemonProvider>();

    if (provider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (provider.errorMessage != null) {
      return Scaffold(body: Center(child: Text(provider.errorMessage!)));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Pokestore')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: provider.pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = provider.pokemons[index];

          return PokemonCard(pokemon: pokemon);
        },
      ),
    );
  }
}
