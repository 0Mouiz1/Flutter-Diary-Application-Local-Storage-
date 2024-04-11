
import 'dart:io'; // Importing the dart.io library for File operations

import 'package:flutter/material.dart'; // Importing material package from flutter
import 'package:fluttertoast/fluttertoast.dart'; // Importing fluttertoast package for showing toast messages
import 'package:google_fonts/google_fonts.dart'; // Importing google_fonts package for custom fonts
import 'package:image_picker/image_picker.dart'; // Importing image_picker package for picking images
import 'package:recipe_book_local_database/models/recipe_model.dart'; // Importing recipe_model
import 'package:provider/provider.dart'; // Importing provider package for state management

import '../../providers/recipe_provider.dart'; // Importing recipe_provider from a relative path

class EditRecipeScreen extends StatefulWidget {
  final RecipeModel recipeModel; // Declaring a final variable recipeModel of type RecipeModel

  const EditRecipeScreen({super.key, required this.recipeModel}); // Constructor for EditRecipeScreen

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState(); // Creating state for EditRecipeScreen
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  Future pickImage(BuildContext context, ImageSource source) async {
    // Asynchronous method to pick image from gallery or camera
    final image = await ImagePicker().pickImage(source: source); // Picking image
    if (image == null) return; // If image is not selected, return
    Provider.of<RecipeClass>(context, listen: false).image = File(image.path); // Setting picked image as File
    setState(() {}); // Setting state to update UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple[900], // Setting appbar background color
          iconTheme: const IconThemeData(
            color: Colors.white, // Changing color of appbar icons
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20), // Adding circular border to appbar
            ),
          ),
          title: Text(
            'Update 🖊️', // Setting appbar title
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.displayLarge, // Customizing font style
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: Consumer<RecipeClass>( // Using Consumer to listen for changes in RecipeClass
          builder: (context, provider, child) => SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(5), // Adding padding to container
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  TextField(
                    style: TextStyle(
                      color: Colors.deepPurple[900],
                    ),
                    controller: provider.nameController, // Using controller for name input field
                    decoration: InputDecoration(
                        label: Text(
                          'Name', // Setting label for input field
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple[900],
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  // Similar text fields for other details
                  // Omitted for brevity
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.deepPurple[900],
                      ),
                    ),
                    onPressed: () {
                      // Method to save changes
                      if (provider.nameController.text.isEmpty ||
                          provider.preperationTimeController.text.isEmpty ||
                          provider.instructionsController.text.isEmpty ||
                          provider.ingredientsController.text.isEmpty ||
                          provider.image == null) {
                        // Checking if any field is empty
                        Fluttertoast.showToast(
                          msg: "Please fill in all fields", // Showing toast message
                          backgroundColor: Colors.deepPurple[900],
                          textColor: Colors.white,
                        );
                        return;
                      } else {
                        // If all fields are filled
                        widget.recipeModel.name = provider.nameController.text;
                        // Updating recipe model
                        widget.recipeModel.preperationTime = int.parse(
                            provider.preperationTimeController.text != ''
                                ? provider.preperationTimeController.text
                                : '0');
                        widget.recipeModel.image = provider.image;
                        widget.recipeModel.ingredients =
                            provider.ingredientsController.text;
                        widget.recipeModel.instructions =
                            provider.instructionsController.text;
                        provider.updateRecipe(widget.recipeModel); // Updating recipe
                        provider.nameController.clear(); // Clearing controllers
                        provider.preperationTimeController.clear();
                        provider.instructionsController.clear();
                        provider.ingredientsController.clear();
                        provider.image = null; // Resetting image
                        Navigator.of(context).pop(); // Popping the screen
                      }
                    },
                    child: Center(
                        child: Text(
                          'Save Changes', // Button text
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

