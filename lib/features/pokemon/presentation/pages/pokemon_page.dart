import 'package:flutter/material.dart';
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
      body: ListView.builder(
        itemCount: provider.pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = provider.pokemons[index];

          return ListTile(
            leading: Image.network(pokemon.image, width: 50, height: 50),
            title: Text(pokemon.name),
            subtitle: Text('#${pokemon.id}'),
          );
        },
      ),
    );
  }
}
