import 'dart:convert';

import 'package:final_project/models/ingredient.dart';
import 'package:final_project/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class NetworkingRecipes {
  NetworkingRecipes();

  var uuid = Uuid();

  Future<List<Recipe>> getRecipes() async {
    var response = await http.get(
      Uri.parse('https://tasty.p.rapidapi.com/recipes/list?from=0&size=5'),
      headers: {
        'X-RapidAPI-Key': '7269599359msh47a8c1775dd9c2ep1a269ejsne0aaf927008c',
        'X-RapidAPI-Host': 'tasty.p.rapidapi.com'
      },
    );

    if (response.statusCode != 200) {
      print('Request failed with status code ${response.statusCode}');

      throw Error();
    }

    var responseData = json.decode(utf8.decode(response.bodyBytes));

    return parseRecipes(responseData);
  }

  List<Recipe> parseRecipes(var body) {
    var results = body['results'];

    var recipes = List<Recipe>.generate(results.length, (index) {
      final id = uuid.v4();
      final result = results[index];
      final name = result['name'] as String;
      final image = result['thumbnail_url'];
      final sections = result['sections'];
      final ingredientRef = sections[0]['components'];

      final ingredients =
          List<Ingredient>.generate(ingredientRef.length, (index) {
        final ingredient = ingredientRef[index];
        final name = ingredient['ingredient']['name'];
        final amount = ingredient["measurements"][0]["quantity"];
        final measurement = ingredient["measurements"][0]['unit']["name"];
        return Ingredient(name: name, amount: amount, measurement: measurement);
      });

      return Recipe(id: id, name: name, image: image, ingredients: ingredients);
    });

    return recipes;
  }
}
