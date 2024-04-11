import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/recipe_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Define a stateful widget for the New Recipe Screen
class NewRecipeScreen extends StatefulWidget {
  const NewRecipeScreen({super.key});

  @override
  State<NewRecipeScreen> createState() => _NewRecipeScreenState();
}

// Define the state for the New Recipe Screen
class _NewRecipeScreenState extends State<NewRecipeScreen> {
  // Function to pick an image from camera or gallery
  Future pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    // Set the picked image to the provider
    Provider.of<RecipeClass>(context, listen: false).image = File(image.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // App Bar configuration
        title: Text(
          '',
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
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
      ),
      body: Consumer<RecipeClass>(
        // Use the Provider to access and listen to changes in the RecipeClass
        builder: (context, provider, child) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Text Field for Recipe Name
                TextField(
                  style: TextStyle(
                    color: Colors.deepPurple[900],
                  ),
                  controller: provider.nameController,
                  decoration: InputDecoration(
                      label: Text(
                        'Name',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple[900],
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Text Field for Preperation Time
                TextField(
                  style: TextStyle(
                    color: Colors.deepPurple[900],
                  ),
                  keyboardType: TextInputType.number,
                  controller: provider.preperationTimeController,
                  decoration: InputDecoration(
                      label: Text(
                        'ID Number',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple[900],
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Row containing options to pick image
                Row(
                  children: [
                    PopupMenuButton(
                      // Popup menu for picking image from camera or gallery
                      color: !provider.isDark ? Colors.white : null,
                      itemBuilder: ((context) => [
                            PopupMenuItem(
                              onTap: (() =>
                                  pickImage(context, ImageSource.camera)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.deepPurple[900],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Take a picture',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple[900],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: (() =>
                                  pickImage(context, ImageSource.gallery)),
                              child: Row(
                                children: [
                                  Icon(Icons.image_outlined,
                                      color: Colors.deepPurple[900]),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Select a picture',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple[900],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    Text(
                      'Add a picture',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple[900],
                      ),
                    ),
                  ],
                ),
                // Display picked image
                Visibility(
                    visible: provider.image != null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            provider.image = null;
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.cancel_outlined,
                            color: Colors.red,
                          ),
                        ),
                        provider.image != null
                            ? Image.file(
                                provider.image!,
                                width: 100,
                                height: 100,
                              )
                            : Container(),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                // Text Field for Personal Details
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: 100,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.deepPurple[900],
                      ),
                      expands: true,
                      maxLines: null,
                      controller: provider.ingredientsController,
                      decoration: InputDecoration(
                          label: Text(
                            'Personal Details',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple[900],
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please fill in Personal Details",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Text Field for Institutional Details
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: 100,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.deepPurple[900],
                      ),
                      expands: true,
                      maxLines: null,
                      controller: provider.instructionsController,
                      decoration: InputDecoration(
                          fillColor: Colors.deepPurple[900],
                          label: Text(
                            'Institutional Details',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple[900],
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Button to save the new recipe
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.deepPurple[900],
                    ),
                  ),
                  onPressed: () {
                    if (provider.nameController.text.isEmpty ||
                        provider.preperationTimeController.text.isEmpty ||
                        provider.instructionsController.text.isEmpty ||
                        provider.ingredientsController.text.isEmpty ||
                        provider.image == null) {
                      Fluttertoast.showToast(
                        msg: "Please fill in all fields",
                        backgroundColor: Colors.deepPurple[900],
                        textColor: Colors.white,
                      );
                      return;
                    } else {
                      provider.insertNewRecipe();
                      provider.nameController.clear();
                      provider.preperationTimeController.clear();
                      provider.instructionsController.clear();
                      provider.ingredientsController.clear();
                      provider.image = null;
                      Navigator.of(context).pop();
                    }
                  },
                  child: Center(
                    child: Text(
                      'Save',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
