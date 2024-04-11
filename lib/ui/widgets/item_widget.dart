import 'package:flutter/material.dart'; // Importing material.dart package for Flutter UI components.
import 'package:provider/provider.dart'; // Importing provider.dart package for state management.
import '../../models/item_model.dart'; // Importing item_model.dart to use ItemModel class.
import '../../providers/item_provider.dart'; // Importing item_provider.dart to use ItemClass provider.

class ItemWidget extends StatelessWidget { // Defining a StatelessWidget called ItemWidget.
  final ItemModel itemModel; // Declaring a final variable itemModel of type ItemModel.

  const ItemWidget(this.itemModel, {super.key}); // Constructor for ItemWidget.

  @override
  Widget build(BuildContext context) { // Building the UI for ItemWidget.
    return Container( // Creating a Container widget.
      padding: const EdgeInsets.all(5), // Setting padding for the Container.
      margin: const EdgeInsets.all(5), // Setting margin for the Container.
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)), // Adding border radius to Container.
      child: CheckboxListTile( // Creating a CheckboxListTile widget.
        value: itemModel.isComplete, // Setting the value of CheckboxListTile based on itemModel's isComplete property.
        onChanged: (bool? value) { // Defining onChanged callback for CheckboxListTile.
          Provider.of<ItemClass>(context, listen: false).updateItem(itemModel); // Updating item using Provider.
        },
        title: Text( // Adding title to CheckboxListTile.
          itemModel.name, // Displaying the name of the item.
          style: TextStyle( // Setting text style for the title.
            color: Colors.black, // Setting text color to black.
          ),
        ),
        secondary: InkWell( // Adding secondary widget to CheckboxListTile.
          child: const Icon( // Adding Icon widget as child of InkWell.
            Icons.delete, // Adding delete icon.
            color: Colors.black, // Setting icon color to black.
          ),
          onTap: () { // Defining onTap callback for InkWell.
            Provider.of<ItemClass>(context, listen: false).deleteItem(itemModel); // Deleting item using Provider.
          },
        ),
      ),
    );
  }
}
