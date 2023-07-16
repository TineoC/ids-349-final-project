import 'package:final_project/models/recipe.dart';
import 'package:flutter/material.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  @override
  _RecipeDetailsScreenState createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  int sliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.network(
                widget.recipe.image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Ingredients:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.recipe.ingredients.length,
                itemBuilder: (context, index) {
                  final ingredient = widget.recipe.ingredients[index];
                  final amount = parseValue(ingredient.amount) * sliderValue;
                  return ListTile(
                    title: Text(
                      '${ingredient.name} ${ingredient.measurement ?? ''}: $amount',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              '$sliderValue Servings:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Slider(
              value: sliderValue.roundToDouble(),
              min: 1,
              max: 50,
              divisions: 50,
              label: sliderValue.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  sliderValue = value.round();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

double parseValue(String input) {
  if (input.contains("½")) {
    input = input.replaceAll("½", "1/2");
  } else if (input.contains("¼")) {
    input = input.replaceAll("¼", "1/4");
  } else if (input.contains("¾")) {
    input = input.replaceAll("¾", "3/4");
  } else if (input.contains("⅓")) {
    input = input.replaceAll("⅓", "1/3");
  } else if (input.contains("⅔")) {
    input = input.replaceAll("⅔", "2/3");
  } else if (input.contains("⅕")) {
    input = input.replaceAll("⅕", "1/5");
  } else if (input.contains("⅖")) {
    input = input.replaceAll("⅖", "2/5");
  } else if (input.contains("⅗")) {
    input = input.replaceAll("⅗", "3/5");
  } else if (input.contains("⅘")) {
    input = input.replaceAll("⅘", "4/5");
  } else if (input.contains("⅙")) {
    input = input.replaceAll("⅙", "1/6");
  } else if (input.contains("⅚")) {
    input = input.replaceAll("⅚", "5/6");
  } else if (input.contains("⅐")) {
    input = input.replaceAll("⅐", "1/7");
  } else if (input.contains("⅛")) {
    input = input.replaceAll("⅛", "1/8");
  } else if (input.contains("⅜")) {
    input = input.replaceAll("⅜", "3/8");
  } else if (input.contains("⅝")) {
    input = input.replaceAll("⅝", "5/8");
  } else if (input.contains("⅞")) {
    input = input.replaceAll("⅞", "7/8");
  } else if (input.contains("1 ½")) {
    input = input.replaceAll("1 ½", "1.5");
  }

  if (input.contains('/')) {
    List<String> parts = input.split('/');
    if (input.contains(' ')) {
      // Handle mixed numbers (e.g., "1 1/2")
      List<String> wholeAndFraction = input.split(' ');
      int whole = int.parse(wholeAndFraction[0]);
      List<String> fractionParts = wholeAndFraction[1].split('/');
      int numerator = int.parse(fractionParts[0]);
      int denominator = int.parse(fractionParts[1]);
      return whole + (numerator / denominator);
    } else {
      // Handle fractions (e.g., "1/2")
      int numerator = int.parse(parts[0]);
      int denominator = int.parse(parts[1]);
      return numerator / denominator;
    }
  } else {
    // Handle integers
    return double.parse(double.parse(input).toStringAsFixed(2));
  }
}
