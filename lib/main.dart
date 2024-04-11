import 'package:flutter/material.dart'; // Importing the Flutter Material library
import 'package:flutter/services.dart'; // Importing the Flutter Services library
import 'package:recipe_book_local_database/data_repository/item_dbHelper.dart'; // Importing a local data repository
import 'package:recipe_book_local_database/providers/item_provider.dart'; // Importing item provider
import 'package:recipe_book_local_database/providers/recipe_provider.dart'; // Importing recipe provider
import 'package:recipe_book_local_database/ui/screens/marked_list_screen.dart'; // Importing a UI screen
import 'package:recipe_book_local_database/ui/screens/main_data_screen.dart'; // Importing a UI screen
import 'package:recipe_book_local_database/ui/screens/new_data_screen.dart'; // Importing a UI screen
import 'package:recipe_book_local_database/ui/screens/Task_list_screen.dart'; // Importing a UI screen
import 'package:recipe_book_local_database/ui/screens/splash_screen.dart'; // Importing a UI screen
import 'package:provider/provider.dart'; // Importing Provider library

import 'data_repository/dbHelper.dart'; // Importing local data repository

void main() async {
  // Setting preferred orientations
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);

  // Ensuring Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Setting preferred orientations
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); // To turn

  // Ensuring Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initializing local database
  await DbHelper.dbHelper.initDatabase();
  await ItemDbHelper.dbHelper.initDatabase();

  // Running the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      // Providing change notifier for RecipeClass
      ChangeNotifierProvider<RecipeClass>(
        create: (context) => RecipeClass(),
      ),
      // Providing change notifier for ItemClass
      ChangeNotifierProvider<ItemClass>(
        create: (context) => ItemClass(),
      ),
    ], child: const InitApp());
  }
}

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Disabling debug banner
      // Setting theme based on provider's state
      theme: Provider.of<RecipeClass>(context).isDark
          ? ThemeData.dark()
          : ThemeData(
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.white,
              dialogBackgroundColor: Colors.white,
              primaryColor: Colors.white),
      title: 'e-NoteBook',
      // App title
      home: const SplashScreen(),
      // Initial screen
      routes: {
        // Defining named routes for navigation
        '/favorite_recipes_screen': (context) => const FavoriteRecipesScreen(),
        '/new_recipe_screen': (context) => const NewRecipeScreen(),
        '/main_recipe_screen': (context) => const MainRecipeScreen(),
        '/shopping_list_screen': (context) => const ShoppingListScreen(),
      },
    );
  }
}
