import 'package:flutter/material.dart';
import 'package:project_ma/main.dart';
import 'stock_item.dart';

class ManageStockPage extends StatefulWidget {
  @override
  _ManageStockState createState() => _ManageStockState();
}

class _ManageStockState extends State<ManageStockPage> {
  final List<String> categories = [
    "Roofing and Siding",
    "Sanitary and Plumbing",
    "Electrical",
    "Flooring",
    "Doors and Windows",
    "Paint and Coatings",
  ];

  final List<String> warehouseLocations = [
    "Warehouse A",
    "Warehouse B",
    "Warehouse C",
    "Warehouse D",
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String selectedCategory = "Roofing and Siding";
  String selectedWarehouse = "Warehouse A";

  void addItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Item"),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Item Name"),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  value: selectedCategory,
                  items: categories.map((String category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value.toString();
                    });
                  },
                  decoration: InputDecoration(labelText: "Category"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Quantity"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Price"),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  value: selectedWarehouse,
                  items: warehouseLocations.map((String location) {
                    return DropdownMenuItem(
                      value: location,
                      child: Text(location),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedWarehouse = value.toString();
                    });
                  },
                  decoration: InputDecoration(labelText: "Warehouse"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); //go back to the previous screen
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Add the new item to the list
                StockItem newItem = StockItem(
                  name: nameController.text,
                  category: selectedCategory,
                  price: double.parse(priceController.text),
                  quantity: int.parse(quantityController.text),
                  warehouse: selectedWarehouse,
                );

                setState(() {
                  stockItems.add(newItem);
                });

                nameController.clear();
                quantityController.clear();

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item ${newItem.name} added successfully'),
                  ),
                );
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void deleteItem(int stockId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  stockItems.removeWhere((item) => item.id == stockId);
                });
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item deleted successfully'),
                  ),
                );
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void editItem(StockItem item) {
    // Populate the text controllers with the existing item's data
    nameController.text = item.name;
    selectedCategory = item.category;
    quantityController.text = item.quantity.toString();
    priceController.text = item.price.toString();
    selectedWarehouse = item.warehouse;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Item"),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Item Name"),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  value: selectedCategory,
                  items: categories.map((String category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value.toString();
                    });
                  },
                  decoration: InputDecoration(labelText: "Category"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Quantity"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Price"),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  value: selectedWarehouse,
                  items: warehouseLocations.map((String location) {
                    return DropdownMenuItem(
                      value: location,
                      child: Text(location),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedWarehouse = value.toString();
                    });
                  },
                  decoration: InputDecoration(labelText: "Warehouse"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Create a new item with updated details
                StockItem updatedItem = StockItem(
                  name: nameController.text,
                  category: selectedCategory,
                  quantity: int.parse(quantityController.text),
                  price: double.parse(priceController.text),
                  warehouse: selectedWarehouse,
                );

                // Replace the old item with the updated item
                setState(() {
                  int index = stockItems.indexOf(item);
                  if (index != -1) {
                    stockItems[index] = updatedItem;
                  }
                });

                nameController.clear();
                quantityController.clear();

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('Item ${updatedItem.name} updated successfully'),
                  ),
                );
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Management'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: addItem,
            child: Text("Add Item"),
          ),
          SizedBox(height: 20),

          // Display the list of items
          Expanded(
            child: ListView.builder(
              itemCount: stockItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(stockItems[index].name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Id: ${stockItems[index].id}'),
                      Text('Quantity: ${stockItems[index].quantity}'),
                      Text('Category: ${stockItems[index].category}'),
                      Text('Warehouse: ${stockItems[index].warehouse}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editItem(stockItems[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteItem(stockItems[index].id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
