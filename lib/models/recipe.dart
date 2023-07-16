import 'ingredient.dart';

class Recipe {
  String id;
  String name;
  String image;
  List<Ingredient> ingredients;

  Recipe(
      {required this.id,
      required this.name,
      required this.image,
      required this.ingredients});
}
