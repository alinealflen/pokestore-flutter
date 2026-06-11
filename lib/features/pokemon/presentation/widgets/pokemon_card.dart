import 'package:flutter/material.dart';

import '../../domain/entities/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.network(pokemon.image, fit: BoxFit.contain)),
            const SizedBox(height: 8),
            Text(
              pokemon.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('R\$ ${pokemon.price.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
