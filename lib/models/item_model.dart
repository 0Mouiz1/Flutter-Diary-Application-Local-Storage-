
import '../data_repository/item_dbHelper.dart';

// Defining a class called ItemModel to represent items in the application
class ItemModel {
  // Declaring instance variables id, name, and isComplete
  // The 'late' keyword indicates that the variables will be initialized later
  late int? id;
  late String name;
  late bool isComplete;

  // Constructor for the ItemModel class
  ItemModel({
    this.id, // Optional parameter for item ID
    required this.name, // Required parameter for item name
    required this.isComplete, // Required parameter for item completion status
  });

  // Method to convert ItemModel object to a map of key-value pairs
  Map<String, dynamic> toMap() {
    return {
      // Mapping item properties to database column names using dbHelper
      ItemDbHelper.dbHelper.idColumn: id,
      ItemDbHelper.dbHelper.nameColumn: name,
      ItemDbHelper.dbHelper.isCompleteColumn: isComplete ? 1 : 0, // Storing boolean as integer (1 or 0)
    };
  }

  // Factory constructor to create an ItemModel object from a map
  factory ItemModel.fromMap(Map<String, dynamic> m) {
    return ItemModel(
      // Retrieving values from the map using dbHelper column names
      id: m[ItemDbHelper.dbHelper.idColumn],
      name: m[ItemDbHelper.dbHelper.nameColumn],
      // Converting integer back to boolean for isComplete status
      isComplete: m[ItemDbHelper.dbHelper.isCompleteColumn] == 1 ? true : false,
    );
  }
}
