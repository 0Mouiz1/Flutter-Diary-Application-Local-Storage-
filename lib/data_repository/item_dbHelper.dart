
import 'dart:io'; // Importing the dart:io library for file operations.

import 'package:recipe_book_local_database/models/item_model.dart'; // Importing the ItemModel class from another file.
import 'package:path_provider/path_provider.dart'; // Importing path_provider package for accessing the application directory.
import 'package:sqflite/sqflite.dart'; // Importing sqflite package for SQLite database operations.

class ItemDbHelper {
  late Database database; // Declaring a late variable to hold the database reference.
  static ItemDbHelper dbHelper = ItemDbHelper(); // Creating a singleton instance of ItemDbHelper class.
  final String tableName = 'items'; // Declaring a constant variable for table name.
  final String nameColumn = 'name'; // Declaring a constant variable for column name.
  final String idColumn = 'id'; // Declaring a constant variable for column id.
  final String isCompleteColumn = 'isComplete'; // Declaring a constant variable for column isComplete.

  // Method to initialize the database connection.
  initDatabase() async {
    database = await connectToDatabase();
  }

  // Method to connect to the SQLite database.
  Future<Database> connectToDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory(); // Getting the application documents directory.
    String path = '$directory/items.db'; // Constructing the database path.
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Callback method executed when the database is created.
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $isCompleteColumn INTEGER)');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        // Callback method executed when the database is upgraded.
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $isCompleteColumn INTEGER)');
      },
      onDowngrade: (db, oldVersion, newVersion) {
        // Callback method executed when the database is downgraded.
        db.delete(tableName); // Deleting the table if downgrade occurs.
      },
    );
  }

  // Method to fetch all items from the database.
  Future<List<ItemModel>> getAllItems() async {
    List<Map<String, dynamic>> items = await database.query(tableName); // Querying all items from the table.
    return items.map((e) => ItemModel.fromMap(e)).toList(); // Converting fetched data into ItemModel objects.
  }

  // Method to insert a new item into the database.
  insertNewItem(ItemModel itemModel) {
    database.insert(tableName, itemModel.toMap()); // Inserting a new item into the table.
  }

  // Method to delete an item from the database.
  deleteItem(ItemModel itemModel) {
    database.delete(tableName, where: '$idColumn=?', whereArgs: [itemModel.id]); // Deleting an item based on its id.
  }

  // Method to delete all items from the database.
  deleteItems() {
    database.delete(tableName); // Deleting all items from the table.
  }

  // Method to update an existing item in the database.
  updateItem(ItemModel itemModel) {
    database.update(
        tableName, {isCompleteColumn: !itemModel.isComplete ? 1 : 0},
        where: '$idColumn=?', whereArgs: [itemModel.id]); // Updating an item's completion status.
  }
}
