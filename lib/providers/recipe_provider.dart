
import 'dart:io'; // Importing the 'dart:io' library to work with files.

import 'package:flutter/material.dart'; // Importing the material package from Flutter.
import '../data_repository/dbHelper.dart'; // Importing the dbHelper class from the data_repository folder.
import '../models/recipe_model.dart'; // Importing the recipe_model class from the models folder.

class RecipeClass extends ChangeNotifier {
  RecipeClass() {
    getRecipes(); // Calling the getRecipes method when an instance of RecipeClass is created.
  }

  bool isDark = false; // Boolean variable to store the dark mode status.
  changeIsDark() {
    isDark = !isDark; // Toggling the dark mode status.
    notifyListeners(); // Notifying listeners about the change in state.
  }

  TextEditingController nameController = TextEditingController(); // Controller for recipe name text field.
  TextEditingController preperationTimeController = TextEditingController(); // Controller for preparation time text field.
  TextEditingController instructionsController = TextEditingController(); // Controller for instructions text field.
  TextEditingController ingredientsController = TextEditingController(); // Controller for ingredients text field.
  File? image; // Variable to store the image file.

  List<RecipeModel> allRecipes = []; // List to store all recipes.
  List<RecipeModel> favoriteRecipes = []; // List to store favorite recipes.
  getRecipes() async {
    allRecipes = await DbHelper.dbHelper.getAllRecipes(); // Fetching all recipes from the database.
    favoriteRecipes = allRecipes.where((e) => e.isFavorite).toList(); // Filtering favorite recipes from all recipes.
    notifyListeners(); // Notifying listeners about the change in state.
  }

  insertNewRecipe() {
    RecipeModel recipeModel = RecipeModel(
        name: nameController.text,
        isFavorite: false,
        image: image,
        ingredients: ingredientsController.text,
        instructions: instructionsController.text,
        preperationTime: int.parse(preperationTimeController.text != ''
            ? preperationTimeController.text
            : '0')); // Creating a new RecipeModel object with data from text fields.
    DbHelper.dbHelper.insertNewRecipe(recipeModel); // Inserting the new recipe into the database.
    getRecipes(); // Updating the list of recipes.
  }

  updateRecipe(RecipeModel recipeModel) async {
    await DbHelper.dbHelper.updateRecipe(recipeModel); // Updating the recipe in the database.
    getRecipes(); // Updating the list of recipes.
  }

  updateIsFavorite(RecipeModel recipeModel) {
    DbHelper.dbHelper.updateIsFavorite(recipeModel); // Updating the favorite status of the recipe in the database.
    getRecipes(); // Updating the list of recipes.
  }

  deleteRecipe(RecipeModel recipeModel) {
    DbHelper.dbHelper.deleteRecipe(recipeModel); // Deleting the recipe from the database.
    getRecipes(); // Updating the list of recipes.
  }
}
