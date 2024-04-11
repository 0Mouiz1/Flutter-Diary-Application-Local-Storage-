import 'package:flutter/material.dart'; // Importing the material package for UI components
import 'package:recipe_book_local_database/providers/recipe_provider.dart'; // Importing recipe provider for managing state
import 'package:recipe_book_local_database/ui/screens/show_data_screen.dart'; // Importing the screen to show recipe details
import 'package:provider/provider.dart'; // Importing Provider for state management

import '../../models/recipe_model.dart'; // Importing the recipe model

class RecipeWidget extends StatelessWidget { // Creating a stateless widget named RecipeWidget
  final RecipeModel recipeModel; // Declaring a final variable to hold a RecipeModel object

  const RecipeWidget(this.recipeModel, {super.key}); // Constructor for RecipeWidget

  @override
  Widget build(BuildContext context) { // Build method to build the UI
    return InkWell( // InkWell for making the widget tappable
      onTap: (() {
        Navigator.push( // Navigating to the ShowRecipeScreen when tapped
            context,
            MaterialPageRoute(
                builder: ((context) =>
                    ShowRecipeScreen(recipeModel: recipeModel))));
      }),
      child: Container( // Container to hold the visual elements of the recipe
        decoration: BoxDecoration(
            color: !Provider.of<RecipeClass>(context).isDark
                ? Colors.deepPurple[900]
                : null,
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: ListTile( // ListTile to display recipe details
          tileColor:
          !Provider.of<RecipeClass>(context).isDark ? Colors.white : null,
          leading: recipeModel.image == null
              ? Container(
            decoration: BoxDecoration(
                color: !Provider.of<RecipeClass>(context).isDark
                    ? Colors.green
                    : null,
                borderRadius: BorderRadius.circular(8)),
            height: double.infinity,
            width: 70,
            child: const Center(
              child: Text(''),
            ),
          )
              : Image.file( // Displaying the recipe image
            recipeModel.image!,
            width: 70,
            height: double.infinity,
          ),
          title: Text(
            recipeModel.name, // Displaying the recipe name
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '${recipeModel.preperationTime} ', // Displaying the preparation time
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: InkWell( // InkWell for making the favorite button tappable
            onTap: () {
              Provider.of<RecipeClass>(context, listen: false)
                  .updateIsFavorite(recipeModel); // Updating the favorite status
            },
            child: recipeModel.isFavorite
                ? const Icon(
              Icons.error, // Showing filled heart icon if it's a favorite
              size: 60,
              color: Colors.white,
            )
                : const Icon(
              Icons.error_outline, // Showing empty heart icon if it's not a favorite
              color: Colors.white,
              size: 60,
            ),
          ),
        ),
      ),
    );
  }
}
