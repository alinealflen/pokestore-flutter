import 'package:flutter/material.dart';
import 'package:pokestore/features/pokemon/presentation/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';

import '../providers/pokemon_provider.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});
  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        context.read<PokemonProvider>().loadMorePokemons();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: provider.setSearch,
              decoration: const InputDecoration(
                hintText: 'Buscar Pokémon...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: provider.filteredPokemons.length,

              itemBuilder: (context, index) {
                final pokemon = provider.filteredPokemons[index];

                return PokemonCard(pokemon: pokemon);
              },
            ),
          ),
        ],
      ),
    );
  }
}
