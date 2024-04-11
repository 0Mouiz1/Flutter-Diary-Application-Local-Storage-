
import 'dart:io'; // Importing the 'dart:io' library for system operations like exiting the app
import 'package:google_fonts/google_fonts.dart'; // Importing Google Fonts package
import 'package:flutter/material.dart'; // Importing Flutter Material package
import 'package:recipe_book_local_database/providers/recipe_provider.dart'; // Importing recipe provider
import 'package:recipe_book_local_database/ui/screens/search_data_screen.dart'; // Importing search data screen
import 'package:provider/provider.dart'; // Importing Provider package

import '../widgets/container_widget.dart'; // Importing custom container widget

class MainRecipeScreen extends StatelessWidget {
  const MainRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>( // Using Consumer to listen for changes in RecipeClass
        builder: (BuildContext context, myProvider, Widget? child) => Scaffold( // Building the scaffold widget
          appBar: AppBar( // AppBar widget
            title: Text( // Title of the app bar
              '',
              style: GoogleFonts.poppins( // Using Google Fonts for the text style
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
            centerTitle: true, // Centering the title
            backgroundColor: Colors.deepPurple[900], // Setting background color
            iconTheme: const IconThemeData( // Setting icon theme
              color:
              Colors.white, // Change the color of the drawer icon here
            ),
            shape: const RoundedRectangleBorder( // Setting border radius for app bar
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20), // Circular border radius
              ),
            ),
            actions: [
              InkWell( // InkWell for search icon
                  onTap: () => Navigator.of(context).push(MaterialPageRoute( // Navigate to search screen on tap
                      builder: ((context) => SearchRecipeScreen(
                          recipes: myProvider.allRecipes)))), // Passing all recipes to search screen
                  child: const Icon(Icons.search)), // Search icon
              PopupMenuButton( // Popup menu button for additional actions
                color: !myProvider.isDark ? Colors.white : null, // Setting color based on theme
                itemBuilder: ((context) => [
                  PopupMenuItem( // First popup menu item
                    onTap: (() => Scaffold.of(context).openDrawer()), // Open drawer on tap
                    child: Text( // Text for menu item
                      'Open menu',
                      style: TextStyle(
                        color: Colors.deepPurple[900], // Text color
                      ),
                    ),
                  ),
                  PopupMenuItem( // Second popup menu item
                    child: Text( // Text for menu item
                      'About',
                      style: TextStyle(
                        color: Colors.deepPurple[900], // Text color
                      ),
                    ),
                  ),
                  PopupMenuItem( // Third popup menu item
                    onTap: (() => exit(0)), // Exit app on tap
                    child: Column( // Column for icon and text
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row( // Row for icon and text
                          children: [
                            Icon( // Exit icon
                              Icons.exit_to_app_outlined,
                              color: Colors.deepPurple[900], // Icon color
                            ),
                            SizedBox( // SizedBox for spacing
                              width: 10,
                            ),
                            Text( // Text for menu item
                              'Exit',
                              style: TextStyle(
                                color: Colors.deepPurple[900], // Text color
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton( // Floating action button for adding new recipe
            backgroundColor: Colors.deepPurple[900], // Button background color
            onPressed: (() async { // On tap function
              await Navigator.pushNamed(context, '/new_recipe_screen'); // Navigate to new recipe screen
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(
                  context, '/main_recipe_screen'); // Replace current screen with main recipe screen
            }),
            child: const Icon( // Icon for floating action button
              Icons.add,
              color: Colors.white, // Icon color
            ),
          ),
          drawer: Drawer( // Drawer widget for side menu
            backgroundColor: !myProvider.isDark ? Colors.white : null, // Drawer background color based on theme
            child: Column( // Column for drawer content
              children: [
                Container( // Container for drawer header
                  //width: double.infinity,
                  height: 200,
                ),
                ListTile( // List tile for home screen
                  title: const Text('Home'), // Title text
                  leading: Icon( // Icon
                    Icons.home,
                    color: Colors.deepPurple[900], // Icon color
                  ),
                  onTap: () { // On tap function
                    Navigator.pushReplacementNamed(
                        context, '/main_recipe_screen'); // Replace current screen with main recipe screen
                  },
                ),
                ListTile( // List tile for favorite recipes
                  title: const Text('Marked Individuals'), // Title text
                  leading: Icon( // Icon
                    Icons.error,
                    color: Colors.deepPurple[900], // Icon color
                  ),
                  onTap: () { // On tap function
                    Navigator.pushReplacementNamed(
                        context, '/favorite_recipes_screen'); // Replace current screen with favorite recipes screen
                  },
                ),
                ListTile( // List tile for shopping list
                  title: const Text('Task List'), // Title text
                  leading: Icon( // Icon
                    Icons.work,
                    color: Colors.deepPurple[900], // Icon color
                  ),
                  onTap: () { // On tap function
                    Navigator.pushNamed(context, '/shopping_list_screen'); // Navigate to shopping list screen
                  },
                ),
                Provider.of<RecipeClass>(context).isDark // Conditional list tile for changing theme
                    ? ListTile( // List tile for light mode
                  title: const Text('Light Mode'), // Title text
                  leading: Icon( // Icon
                    Icons.light_mode_outlined,
                    color: Colors.deepPurple[900], // Icon color
                  ),
                  onTap: () { // On tap function
                    Provider.of<RecipeClass>(context, listen: false) // Change theme
                        .changeIsDark();
                    Navigator.pop(context); // Close drawer
                  },
                )
                    : ListTile( // List tile for dark mode
                  title: const Text('Dark Mode'), // Title text
                  leading: Icon( // Icon
                    Icons.dark_mode_outlined,
                    color: Colors.deepPurple[900], // Icon color
                  ),
                  onTap: () { // On tap function
                    Provider.of<RecipeClass>(context, listen: false) // Change theme
                        .changeIsDark();
                    Navigator.pop(context); // Close drawer
                  },
                ),
              ],
            ),
          ),
          body: ListView.builder( // List view for displaying recipes
              itemCount: myProvider.allRecipes.length, // Total number of recipes
              itemBuilder: (context, index) { // Item builder for each recipe
                return RecipeWidget(myProvider.allRecipes[index]); // Returning RecipeWidget for each recipe
              }),
        ));
  }
}
