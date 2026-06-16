import 'package:flutter/material.dart';

import '../../domain/entities/pokemon.dart';
import '../pages/pokemon_detail_page.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PokemonDetailPage(pokemon: pokemon),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.network(pokemon.image, fit: BoxFit.contain),
              ),
              const SizedBox(height: 12),
              Text(pokemon.name.toUpperCase(), textAlign: TextAlign.center),
              Text('R\$ ${pokemon.price.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
