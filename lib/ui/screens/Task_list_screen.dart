// Ignore file_names warning
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/item_provider.dart';
import '../../providers/recipe_provider.dart';
import '../widgets/item_widget.dart';
import 'dart:io';

// Define ShoppingListScreen as a StatelessWidget
class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  // Build method for the ShoppingListScreen widget
  @override
  Widget build(BuildContext context) {
    // Consume two providers: RecipeClass and ItemClass
    return Consumer2<RecipeClass, ItemClass>(
        builder: ((context, provider, provider2, child) => Scaffold(
          // Scaffold widget for the overall structure
          appBar: AppBar(
            // AppBar with customization
            centerTitle: true,
            backgroundColor: Colors.deepPurple[900],
            iconTheme: const IconThemeData(
              color:
              Colors.white, // Change the color of the drawer icon here
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20), // Circular border radius
              ),
            ),
            title: const Text(
              'Tasks 🖊️',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          drawer: Drawer(
            // Drawer for navigation options
            child: Column(
              children: [
                Container(
                  height: 200,
                ),
                ListTile(
                  // ListTile for each navigation option
                  title: Text(
                    'Home',
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
                // Other navigation options
                // (omitted for brevity)
              ],
            ),
          ),
          body: Column(
            // Column to hold the main content of the screen
            children: [
              Expanded(
                // Expanded widget to make the ListView fill the available space
                child: ListView.builder(
                    itemCount: provider2.allItems.length,
                    itemBuilder: (context, index) {
                      return ItemWidget(provider2.allItems[index]);
                    }),
              ),
              const SizedBox(height: 10),
              // Row containing text field and button for adding new tasks
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      controller: provider2.textEditingController,
                      decoration: InputDecoration(
                          label: const Text(
                            'Add a Task',
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.deepPurple[900]),
                    ),
                    onPressed: () {
                      // Insert a new item when button is pressed
                      provider2.insertNewItem();
                      provider2.textEditingController.clear();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        )));
  }
}
