import 'package:flutter/material.dart';
import '../view_Model/pokemon_view_model.dart';
import '../model/pokemon.dart';

class PokemonView extends StatefulWidget {
  @override
  _PokemonViewState createState() => _PokemonViewState();
}

class _PokemonViewState extends State<PokemonView> {
  final viewModel = PokemonViewModel();
  final _controller = TextEditingController();
  Pokemon? _pokemon;
  String? _error;

  void _searchPokemon() async {
    final name = _controller.text.trim().toLowerCase();
    if (name.isEmpty) {
      setState(() {
        _error = 'Por favor, digite o nome de um Pokémon.';
        _pokemon = null;
      });
      return;
    }

    try {
      final pokemon = await viewModel.fetchPokemon(name);
      setState(() {
        _pokemon = pokemon;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _pokemon = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisar Pokémon'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nome do Pokémon',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchPokemon,
              child: Text('Pesquisar'),
            ),
            SizedBox(height: 16),
            if (_error != null)
              Text(
                _error!,
                style: TextStyle(color: Colors.red),
              ),
            if (_pokemon != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    _pokemon!.imageUrl,
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Nome: ${_pokemon!.name}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Habilidades:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ..._pokemon!.abilities
                      .map((ability) => Text(ability))
                      .toList(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
