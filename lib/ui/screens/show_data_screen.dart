// Import necessary packages and files
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_local_database/models/recipe_model.dart';
import 'package:recipe_book_local_database/providers/recipe_provider.dart';
import 'package:provider/provider.dart';

// Import the screen for editing data
import 'edit_data_screen.dart';

// Define a StatelessWidget for displaying recipe details
class ShowRecipeScreen extends StatelessWidget {
  // Declare variables
  final RecipeModel recipeModel;

  // Constructor
  const ShowRecipeScreen({super.key, required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    // Return a Scaffold widget with Consumer for accessing provider
    return Consumer<RecipeClass>(
        builder: ((context, provider, child) => Scaffold(
          // App bar with edit and delete options
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.deepPurple[900],
            iconTheme: const IconThemeData(
              color:
              Colors.white, // Change the color of the drawer icon here
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20), // Circular border radius
              ),
            ),
            actions: [
              // Edit button
              InkWell(
                  onTap: () {
                    // Set values to provider for editing
                    provider.nameController.text = recipeModel.name;
                    provider.preperationTimeController.text =
                        recipeModel.preperationTime.toString();
                    provider.ingredientsController.text =
                        recipeModel.ingredients;
                    provider.instructionsController.text =
                        recipeModel.instructions;
                    provider.image = recipeModel.image;
                    // Navigate to edit screen
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => EditRecipeScreen(
                                recipeModel: recipeModel))));
                  },
                  child: const Icon(
                    Icons.edit,
                  )),
              const SizedBox(
                width: 20,
              ),
              // Delete button
              InkWell(
                  onTap: () {
                    // Call deleteRecipe method from provider
                    provider.deleteRecipe(recipeModel);
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.delete)),
            ],
          ),
          // Body with recipe details
          body: SingleChildScrollView(
            child: Column(children: [
              // Display recipe image
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: !Provider.of<RecipeClass>(context).isDark
                        ? Colors.deepPurple[900]
                        : null,
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                height: 170,
                child: recipeModel.image == null
                    ? const Text('')
                    : Image.file(
                  recipeModel.image!,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Display recipe name
              Center(
                child: Text(
                  recipeModel.name,
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple[900],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Display preparation time
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: !Provider.of<RecipeClass>(context).isDark
                        ? Colors.deepPurple[900]
                        : null,
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Text(
                      '${recipeModel.preperationTime}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Display recipe ingredients
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: !Provider.of<RecipeClass>(context).isDark
                        ? Colors.deepPurple[900]
                        : null,
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipeModel.ingredients,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Display recipe instructions
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: !Provider.of<RecipeClass>(context).isDark
                        ? Colors.deepPurple[900]
                        : null,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipeModel.instructions,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        )));
  }
}
