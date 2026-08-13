class PokemonModel {
  final String title;
  final String category;
  final String number;
  final String? imageUrl;
  final String height;
  final String weight;

  PokemonModel({
    required this.title,
    required this.category,
    required this.number,
    this.imageUrl,
    required this.height,
    required this.weight,
  });

  PokemonModel.fromJson(Map<String, dynamic> json)
    : title = json['name'] ?? '',
      category = (json['types'] != null && (json['types'] as List).isNotEmpty) 
          ? json['types'][0]['type']['name'] 
          : 'Unknown',
      number = json['id']?.toString() ?? '0',
      height = json['height']?.toString() ?? '0',
      weight = json['weight']?.toString() ?? '0',
      imageUrl = json['sprites']?['other']?['official-artwork']?['front_default'] 
          ?? json['sprites']?['front_default'];
}
