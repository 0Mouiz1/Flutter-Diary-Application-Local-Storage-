
import 'dart:io';

// Define a class named RecipeModel.
class RecipeModel {
  // Declare an optional integer variable id.
  int? id;
  // Declare a string variable name.
  late String name;
  // Declare a boolean variable isFavorite.
  late bool isFavorite;
  // Declare an optional File variable image.
  File? image;
  // Declare an integer variable preperationTime.
  late int preperationTime;
  // Declare a string variable ingredients.
  late String ingredients;
  // Declare a string variable instructions.
  late String instructions;

  // Define a constructor for RecipeModel class.
  RecipeModel({
    this.id, // id is optional
    required this.name, // name is required
    required this.isFavorite, // isFavorite is required
    this.image, // image is optional
    required this.preperationTime, // preperationTime is required
    required this.ingredients, // ingredients is required
    required this.instructions, // instructions is required
  });

  // Define a method toMap() which converts RecipeModel object to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isFavorite': isFavorite ? 1 : 0,
      'preperationTime': preperationTime,
      'ingredients': ingredients,
      'instructions': instructions,
      'image': image == null ? '' : image!.path
    };
  }

  // Define a factory constructor fromMap() which creates a RecipeModel object from a map.
  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
        id: map['id'], // set id from map
        name: map['name'], // set name from map
        isFavorite: map['isFavorite'] == 1 ? true : false, // set isFavorite from map
        preperationTime: map['preperationTime'], // set preperationTime from map
        ingredients: map['ingredients'], // set ingredients from map
        instructions: map['instructions'], // set instructions from map
        image: map['image'] != null ? File(map['image']) : null); // set image from map
  }
}
