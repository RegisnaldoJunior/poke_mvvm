class Pokemon {
  final String name;
  final List<String> abilities;
  final String imageUrl;

  Pokemon({
    required this.name,
    required this.abilities,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      abilities: (json['abilities'] as List)
          .map((ability) => ability['ability']['name'] as String)
          .toList(),
      imageUrl: json['sprites']['front_default'], // URL da imagem
    );
  }
}
