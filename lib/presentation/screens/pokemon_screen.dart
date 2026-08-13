import 'package:flutter/material.dart';
import 'package:my_app_test/models/pokemon_model.dart';
import 'package:my_app_test/presentation/widgets/pokemon_widget.dart';
import 'package:my_app_test/services/fetch_pokemon_service.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  @override
  Widget build(BuildContext context) {
    final service = FetchPokemonService();
    return Scaffold(
      appBar: AppBar(title: Text("Pokédex App")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<PokemonModel>>(
          future: service.fetchPokemons(),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: asyncSnapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return PokemonWidget(
                    pokemon: asyncSnapshot.data![index],
                  );
                },
              );
            } else if (asyncSnapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 60),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${asyncSnapshot.error}'),
                    ),
                  ],
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
