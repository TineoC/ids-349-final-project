import 'package:final_project/models/recipe.dart';
import 'package:final_project/networking/recipes.dart';

Future<List<Recipe>> getRecipes() async {
  var network = NetworkingRecipes();

  var recipes = await network.getRecipes();

  return recipes;
}
