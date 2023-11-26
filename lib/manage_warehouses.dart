import 'package:flutter/material.dart';
import 'warehouse.dart';
import 'main.dart';
import 'stock_item.dart';

class ManageWarehousesPage extends StatefulWidget {
  @override
  _ManageWarehousesState createState() => _ManageWarehousesState();
}

class _ManageWarehousesState extends State<ManageWarehousesPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  List<StockItem> getItemsByWarehouse(String warehouseName) {
    return stockItems.where((item) => item.warehouse == warehouseName).toList();
  }

  void addWarehouse() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Warehouse"),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Warehouse Name"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(labelText: "Location"),
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
                Warehouse newWarehouse = Warehouse(
                  id: 1,
                  name: nameController.text,
                  location: locationController.text,
                );

                setState(() {
                  warehouses.add(newWarehouse);
                });

                nameController.clear();
                locationController.clear();

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Warehouse ${newWarehouse.name} added successfully'),
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

  void deleteWarehouse(int warehouseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this warehouse?"),
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
                  warehouses
                      .removeWhere((warehouse) => warehouse.id == warehouseId);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void editWarehouse(Warehouse warehouse) {
    nameController.text = warehouse.name;
    locationController.text = warehouse.location;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Warehouse"),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Warehouse Name"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(labelText: "Location"),
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
                Warehouse updatedWarehouse = Warehouse(
                  id: 1,
                  name: nameController.text,
                  location: locationController.text,
                );

                setState(() {
                  int index = warehouses.indexOf(warehouse);
                  if (index != -1) {
                    warehouses[index] = updatedWarehouse;
                  }
                });

                nameController.clear();
                locationController.clear();

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Warehouse ${updatedWarehouse.name} updated successfully'),
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
        title: Text('Warehouses Management'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: addWarehouse,
            child: Text("Add new warehouse"),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: warehouses.length,
              itemBuilder: (context, index) {
                Warehouse warehouse = warehouses[index];
                List<StockItem> items = getItemsByWarehouse(warehouse.name);
                return ListTile(
                  title: Text(warehouses[index].name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Id: ${warehouses[index].id}'),
                      Text('Location: ${warehouses[index].location}'),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, itemIndex) {
                          StockItem item = items[itemIndex];
                          return Text('${item.name}: ${item.quantity} pieces');
                        },
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editWarehouse(warehouses[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteWarehouse(warehouses[index].id);
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
