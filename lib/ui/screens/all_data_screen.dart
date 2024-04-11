
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import the RecipeProvider class
import '../../providers/recipe_provider.dart';

// Import the RecipeWidget class
import '../widgets/container_widget.dart';

// Define the AllRecipesScreen widget
class AllRecipesScreen extends StatelessWidget {
  // Constructor for the AllRecipesScreen widget
  const AllRecipesScreen({super.key});

  // Build method for the AllRecipesScreen widget
  @override
  Widget build(BuildContext context) {
    // Use Consumer widget to listen for changes in RecipeClass
    return Consumer<RecipeClass>(
      builder: (BuildContext context, provider, Widget? child) {
        // Return a ListView.builder to display all recipes
        return ListView.builder(
          // Set the item count to the length of allRecipes list
            itemCount: provider.allRecipes.length,
            // Define the itemBuilder function to build each list item
            itemBuilder: (context, index) {
              // Return a RecipeWidget for each recipe
              return RecipeWidget(provider.allRecipes[index]);
            });
      },
    );
  }
}
