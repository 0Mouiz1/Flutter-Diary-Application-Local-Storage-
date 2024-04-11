
import 'dart:io'; // For exiting the app
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_local_database/ui/screens/search_data_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/recipe_provider.dart';
import '../widgets/container_widget.dart';

// Define FavoriteRecipesScreen class
class FavoriteRecipesScreen extends StatelessWidget {
  const FavoriteRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Return a consumer widget to listen to changes in RecipeClass
    return Consumer<RecipeClass>(
      builder: (BuildContext context, myProvider, Widget? child) {
        // Scaffold widget for the UI
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '', // Title of the app bar
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.deepPurple[900], // App bar color
            iconTheme: const IconThemeData(
              color: Colors.white, // Change the color of the drawer icon here
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20), // Circular border radius
              ),
            ),
            actions: [
              // Icon button for searching recipes
              InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => SearchRecipeScreen(
                          recipes: myProvider.favoriteRecipes)))),
                  child: const Icon(Icons.search)),
              // Popup menu button for additional options
              PopupMenuButton(
                color: !myProvider.isDark ? Colors.white : null, // Popup menu color
                itemBuilder: ((context) => [
                  PopupMenuItem(
                    onTap: (() => Scaffold.of(context).openDrawer()), // Open drawer
                    child: Text(
                      'Open menu', // Menu item text
                      style: GoogleFonts.poppins(
                        // Text style
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple[900],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: Text(
                      'About', // About menu item
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple[900],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: (() => exit(0)), // Exit app
                    child: Column(
                      children: [
                        // Exit menu item
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.exit_to_app_outlined,
                              color: Colors.deepPurple[900],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Exit', // Exit text
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple[900],
                                fontStyle: FontStyle.italic,
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
          // Drawer widget for side menu
          drawer: Drawer(
            backgroundColor: !myProvider.isDark ? Colors.white : null, // Drawer color
            child: Column(
              children: [
                // Drawer header
                Container(
                  height: 200,
                ),
                // Drawer menu items
                ListTile(
                  title: Text(
                    'Home', // Home menu item
                    style: TextStyle(color: Colors.deepPurple[900]),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Colors.deepPurple[900],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/main_recipe_screen');
                  },
                ),
                ListTile(
                  title: Text(
                    'Marked Individuals', // Marked Individuals menu item
                    style: TextStyle(color: Colors.deepPurple[900]),
                  ),
                  leading: Icon(
                    Icons.error,
                    color: Colors.deepPurple[900],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/favorite_recipes_screen');
                  },
                ),
                ListTile(
                  title: Text(
                    'Tasks List', // Tasks List menu item
                    style: TextStyle(color: Colors.deepPurple[900]),
                  ),
                  leading: Icon(
                    Icons.work,
                    color: Colors.deepPurple[900],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/shopping_list_screen');
                  },
                ),
                // Light/Dark mode switch
                Provider.of<RecipeClass>(context).isDark
                    ? ListTile(
                  title: Text(
                    'Light Mode', // Light mode menu item
                    style: TextStyle(color: Colors.deepPurple[900]),
                  ),
                  leading: Icon(
                    Icons.light_mode_outlined,
                    color: Colors.deepPurple[900],
                  ),
                  onTap: () {
                    Provider.of<RecipeClass>(context, listen: false)
                        .changeIsDark();
                    Navigator.pop(context);
                  },
                )
                    : ListTile(
                  title: Text(
                    'Dark Mode', // Dark mode menu item
                    style: TextStyle(color: Colors.deepPurple[900]),
                  ),
                  leading: Icon(
                    Icons.dark_mode_outlined,
                    color: Colors.deepPurple[900],
                  ),
                  onTap: () {
                    Provider.of<RecipeClass>(context, listen: false)
                        .changeIsDark();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          // Body of the screen, displaying favorite recipes
          body: ListView.builder(
              itemCount: myProvider.favoriteRecipes.length,
              itemBuilder: (context, index) {
                return RecipeWidget(myProvider.favoriteRecipes[index]);
              }),
        );
      },
    );
  }
}
