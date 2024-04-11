
import 'dart:io';

// Import necessary packages and models
import 'package:recipe_book_local_database/models/recipe_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Define a class named DbHelper
class DbHelper {
  // Declare a late-initialized Database variable
  late Database database;

  // Create a static instance of DbHelper for singleton pattern
  static DbHelper dbHelper = DbHelper();

  // Define column names for the database table
  final String tableName = 'recipes';
  final String nameColumn = 'name';
  final String idColumn = 'id';
  final String isFavoriteColumn = 'isFavorite';
  final String ingredientsColumn = 'ingredients';
  final String instructionsColumn = 'instructions';
  final String preperationTimeColumn = 'preperationTime';
  final String imageColumn = 'image';

  // Method to initialize the database
  initDatabase() async {
    // Connect to the database
    database = await connectToDatabase();
  }

  // Method to connect to the SQLite database
  Future<Database> connectToDatabase() async {
    // Get the application documents directory
    Directory directory = await getApplicationDocumentsDirectory();
    // Define the path for the database file
    String path = '$directory/recipes.db';
    // Open the database
    return openDatabase(
      path,
      version: 1,
      // Create the database table if it does not exist
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $preperationTimeColumn INTEGER, $isFavoriteColumn INTEGER, $ingredientsColumn TEXT, $instructionsColumn TEXT, $imageColumn TEXT)');
      },
      // Handle database upgrade if necessary
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $preperationTimeColumn INTEGER, $isFavoriteColumn INTEGER, $ingredientsColumn TEXT, $instructionsColumn TEXT, $imageColumn TEXT)');
      },
      // Handle database downgrade if necessary
      onDowngrade: (db, oldVersion, newVersion) {
        db.delete(tableName);
      },
    );
  }

  // Method to fetch all recipes from the database
  Future<List<RecipeModel>> getAllRecipes() async {
    // Query all records from the database table
    List<Map<String, dynamic>> tasks = await database.query(tableName);
    // Map the query results to RecipeModel objects
    return tasks.map((e) => RecipeModel.fromMap(e)).toList();
  }

  // Method to insert a new recipe into the database
  insertNewRecipe(RecipeModel recipeModel) {
    // Insert the recipe data into the database
    database.insert(tableName, recipeModel.toMap());
  }

  // Method to delete a recipe from the database
  deleteRecipe(RecipeModel recipeModel) {
    // Delete the recipe from the database based on its ID
    database
        .delete(tableName, where: '$idColumn=?', whereArgs: [recipeModel.id]);
  }

  // Method to delete all recipes from the database
  deleteRecipes() {
    // Delete all records from the database table
    database.delete(tableName);
  }

  // Method to update an existing recipe in the database
  updateRecipe(RecipeModel recipeModel) async {
    // Update the recipe data in the database
    await database.update(
        tableName,
        {
          isFavoriteColumn: recipeModel.isFavorite ? 1 : 0,
          nameColumn: recipeModel.name,
          preperationTimeColumn: recipeModel.preperationTime,
          imageColumn: recipeModel.image!.path,
          ingredientsColumn: recipeModel.ingredients,
          instructionsColumn: recipeModel.instructions
        },
        where: '$idColumn=?',
        whereArgs: [recipeModel.id]);
  }

  // Method to toggle the isFavorite status of a recipe in the database
  updateIsFavorite(RecipeModel recipeModel) {
    // Toggle the isFavorite status of the recipe in the database
    database.update(
        tableName, {isFavoriteColumn: !recipeModel.isFavorite ? 1 : 0},
        where: '$idColumn=?', whereArgs: [recipeModel.id]);
  }
}
