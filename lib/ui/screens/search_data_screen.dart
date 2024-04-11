import 'package:flutter/material.dart';
import 'package:recipe_book_local_database/models/recipe_model.dart';
import 'package:recipe_book_local_database/ui/widgets/container_widget.dart';

// Define a stateful widget named SearchRecipeScreen
// ignore: must_be_immutable
class SearchRecipeScreen extends StatefulWidget {
  // Declare a list of recipes and a list for filtered recipes
  final List<RecipeModel> recipes;
  List<RecipeModel> filteredRecipes = [];

  // Constructor to initialize the recipes and filteredRecipes lists
  SearchRecipeScreen({super.key, required this.recipes}) {
    filteredRecipes = recipes;
  }

  // Override the createState method to create the state for this widget
  @override
  State<SearchRecipeScreen> createState() => _SearchRecipeScreenState();
}

// Define the state for the SearchRecipeScreen widget
class _SearchRecipeScreenState extends State<SearchRecipeScreen> {
  // Method to filter recipes based on a search value
  void filterRecipes(value) {
    setState(() {
      widget.filteredRecipes = widget.recipes
          .where((recipe) =>
              recipe.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  // Build method to construct the UI for this widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with search functionality
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple[900],
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the color of the drawer icon here
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Circular border radius
          ),
        ),
        title: TextField(
          onChanged: (value) {
            filterRecipes(value);
          },
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: const InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          )
        ],
      ),
      // Body with a list of filtered recipes or an error message if no recipes found
      body: Container(
        padding: const EdgeInsets.all(10),
        child: widget.filteredRecipes.isNotEmpty
            ? ListView.builder(
                itemCount: widget.filteredRecipes.length,
                itemBuilder: (BuildContext context, int index) {
                  return RecipeWidget(widget.filteredRecipes[index]);
                })
            : Center(
                child: Icon(
                  Icons.error,
                  color: Colors.deepPurple[900],
                  size: 200,
                ),
              ),
      ),
    );
  }
}
