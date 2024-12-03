import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/pokemon.dart';

class PokemonViewModel {
  Future<Pokemon> fetchPokemon(String name) async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$name');

    // Faz a requisição para o Pokémon específico
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Pokemon.fromJson(data);
    } else if (response.statusCode == 404) {
      throw Exception('Pokémon não encontrado');
    } else {
      throw Exception('Erro ao carregar dados: ${response.statusCode}');
    }
  }
}
