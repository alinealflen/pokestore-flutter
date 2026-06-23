import 'package:flutter/material.dart';
import 'package:pokestore/features/pokemon/presentation/pages/pokemon_detail_page.dart';
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
  final TextEditingController _searchController = TextEditingController();

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
    _searchController.dispose();
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
              controller: _searchController,
              onChanged: provider.setSearch,
              decoration: const InputDecoration(
                hintText: 'Buscar Pokémon...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          if (provider.search.isNotEmpty)
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: provider.filteredPokemonNames.length,
                itemBuilder: (context, index) {
                  final name = provider.filteredPokemonNames[index];

                  return ListTile(
                    title: Text(name),
                    onTap: () async {
                      final pokemon = await provider.searchPokemon(name);

                      provider.clearSearch();
                      _searchController.clear();

                      if (!mounted) return;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PokemonDetailPage(pokemon: pokemon),
                        ),
                      );
                    },
                  );
                },
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
              itemCount: provider.pokemons.length,

              itemBuilder: (context, index) {
                final pokemon = provider.pokemons[index];

                return PokemonCard(pokemon: pokemon);
              },
            ),
          ),
        ],
      ),
    );
  }
}
