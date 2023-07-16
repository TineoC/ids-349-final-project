import 'package:final_project/models/recipe.dart';
import 'package:final_project/screen/recipe_detail.dart';
import 'package:final_project/service/recipe.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Recipe> recipes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Recipe> fetchedRecipes = await getRecipes();
      print(fetchedRecipes);
      setState(() {
        recipes = fetchedRecipes;
        _isLoading = false;
      });
    } catch (error) {
      // Handle error scenario
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      isLoading: _isLoading,
      skeleton: SkeletonListView(),
      child: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return RecipeCard(recipe: recipe);
        },
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: 360, // Set the desired height
            width: double.infinity, // Set the desired width
            child: Image.network(
              recipe.image,
              fit: BoxFit.cover, // Adjust the image to cover the container
            ),
          ),
          Text(recipe.name,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailsScreen(recipe: recipe),
                ),
              );
            },
            child: const Text('View Details'),
          ),
        ],
      ),
    );
  }
}
