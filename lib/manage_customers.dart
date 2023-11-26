import 'package:flutter/material.dart';
import 'customer.dart';
import 'package:project_ma/main.dart';

class ManageCustomersPage extends StatefulWidget {
  @override
  _ManageCustomersState createState() => _ManageCustomersState();
}

class _ManageCustomersState extends State<ManageCustomersPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController taxNumberController = TextEditingController();

  void addCustomer() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Customer"),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Customer Name"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Phone Number"),
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: "Address"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: taxNumberController,
                  decoration: InputDecoration(labelText: "Tax Number"),
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
                Customer newCustomer = Customer(
                    name: nameController.text,
                    phoneNumber: phoneNumberController.text,
                    address: addressController.text,
                    taxNumber: taxNumberController.text);
                setState(() {
                  customers.add(newCustomer);
                });

                nameController.clear();
                phoneNumberController.clear();
                addressController.clear();
                taxNumberController.clear();

                // Close the dialog
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('Customer ${newCustomer.name} added successfully'),
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

  void deleteCustomer(int customerId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm Deletion"),
            content: Text("Are you sure you want to delete this customer?"),
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
                    customers
                        .removeWhere((customer) => customer.id == customerId);
                  });
                },
                child: Text('Delete'),
              ),
            ],
          );
        });
  }

  void editCustomer(Customer customer) {
    nameController.text = customer.name;
    phoneNumberController.text = customer.phoneNumber;
    addressController.text = customer.address;
    taxNumberController.text = customer.taxNumber;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit customer"),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Customer Name"),
                ),
                SizedBox(height: 10),
                SizedBox(height: 10),
                TextField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "PhoneNumber"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: "Address"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: taxNumberController,
                  decoration: InputDecoration(labelText: "TaxNumber"),
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
                Customer updatedCustomer = Customer(
                    name: nameController.text,
                    phoneNumber: phoneNumberController.text,
                    address: addressController.text,
                    taxNumber: taxNumberController.text);
                setState(() {
                  int index = customers.indexOf(customer);
                  if (index != -1) {
                    customers[index] = updatedCustomer;
                  }
                });
                nameController.clear();
                phoneNumberController.clear();
                addressController.clear();
                taxNumberController.clear();

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Customer ${updatedCustomer.name} updated successfully'),
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
        title: Text('Customers Management'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: addCustomer,
            child: Text("Add new customer"),
          ),
          SizedBox(height: 20),
// displaythe list of customers
          Expanded(
            child: ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(customers[index].name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Id: ${customers[index].id}'),
                      Text('PhoneNumber: ${customers[index].phoneNumber}'),
                      Text('Address: ${customers[index].address}'),
                      Text('TaxNumber: ${customers[index].taxNumber}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editCustomer(customers[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteCustomer(customers[index].id);
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
