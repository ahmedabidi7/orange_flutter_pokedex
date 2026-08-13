import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_app_test/models/pokemon_model.dart';

class FetchPokemonService {
  Future<List<PokemonModel>> fetchPokemons() async {
    // API link
    var url = Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=151");

    var response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> results = jsonDecode(response.body)["results"];

      List<Future<PokemonModel?>> futures = results.map((result) async {
        var detailsUrl = Uri.parse(result['url']);
        var detailsResponse = await http.get(detailsUrl);
        if (detailsResponse.statusCode == HttpStatus.ok) {
          return PokemonModel.fromJson(jsonDecode(detailsResponse.body));
        }
        return null;
      }).toList();

      var resolved = await Future.wait(futures);
      return resolved.whereType<PokemonModel>().toList();
    } else {
      print("There is an error check api, code is not 200");
      throw Exception();
    }
  }
}
