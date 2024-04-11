
import 'package:flutter/material.dart'; // Importing necessary Flutter packages.

import '../data_repository/item_dbHelper.dart'; // Importing the database helper class.
import '../models/item_model.dart'; // Importing the item model class.

class ItemClass extends ChangeNotifier { // Defining a class named ItemClass which extends ChangeNotifier for state management.
  ItemClass() { // Constructor for the ItemClass.
    getItems(); // Calling the getItems method when an instance of ItemClass is created.
  }

  TextEditingController textEditingController = TextEditingController(); // Creating a TextEditingController instance to handle text input.

  List<ItemModel> allItems = []; // List to hold all items.
  List<ItemModel> completeItems = []; // List to hold completed items.
  List<ItemModel> incompleteItems = []; // List to hold incomplete items.

  // Method to fetch items from the database.
  getItems() async {
    allItems = await ItemDbHelper.dbHelper.getAllItems(); // Fetching all items from the database.
    completeItems = allItems.where((e) => e.isComplete).toList(); // Filtering completed items.
    incompleteItems = allItems.where((e) => !e.isComplete).toList(); // Filtering incomplete items.
    notifyListeners(); // Notifying listeners about changes in data.
  }

  // Method to insert a new item into the database.
  insertNewItem() {
    ItemModel itemModel = ItemModel(name: textEditingController.text, isComplete: false); // Creating a new item model instance.
    ItemDbHelper.dbHelper.insertNewItem(itemModel); // Inserting the new item into the database.
    getItems(); // Refreshing the items list.
  }

  // Method to update an existing item in the database.
  updateItem(ItemModel itemModel) {
    ItemDbHelper.dbHelper.updateItem(itemModel); // Updating the item in the database.
    getItems(); // Refreshing the items list.
  }

  // Method to delete a specific item from the database.
  deleteItem(ItemModel itemModel) {
    ItemDbHelper.dbHelper.deleteItem(itemModel); // Deleting the item from the database.
    getItems(); // Refreshing the items list.
  }

  // Method to delete all items from the database.
  deleteItems() {
    ItemDbHelper.dbHelper.deleteItems(); // Deleting all items from the database.
    getItems(); // Refreshing the items list.
  }
}
