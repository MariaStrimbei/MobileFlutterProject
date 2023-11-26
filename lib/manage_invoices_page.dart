import 'package:flutter/material.dart';
import 'invoice.dart';
import 'customer.dart';
import 'stock_item.dart';
import 'main.dart';

class ManageInvoicesPage extends StatefulWidget {
  @override
  _ManageInvoicesState createState() => _ManageInvoicesState();
}

class _ManageInvoicesState extends State<ManageInvoicesPage> {
  TextEditingController itemsController = TextEditingController();
  DateTime? selectedDate;
  Customer? selectedCustomer;
  List<StockItem> selectedStockItems = [];
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
double calculateTotalAmount() {
  return selectedStockItems.fold(0, (previousValue, item) => previousValue + item.price);
}
  void addInvoice() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Invoice"),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                DropdownButton<Customer>(
                  value: selectedCustomer,
                  hint: Text("Select a Customer"),
                  onChanged: (Customer? value) {
                    setState(() {
                      selectedCustomer = value;
                    });
                  },
                  items: customers
                      .map<DropdownMenuItem<Customer>>((Customer customer) {
                    return DropdownMenuItem<Customer>(
                      value: customer,
                      child: Text(customer.name),
                    );
                  }).toList(),
                ),
                TextFormField(
                  onTap: () => _selectDate(context),
                  controller: TextEditingController(
                    text: selectedDate != null
                        ? "${selectedDate!.toLocal()}".split(' ')[0]
                        : "",
                  ),
                  decoration: InputDecoration(labelText: "Date"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _selectStockItems();
                  },
                  child: Text("Select Items"),
                ),
                SizedBox(height: 10),
                Text(
                  "Selected Date: ${selectedDate != null ? selectedDate!.toLocal().toString().split(' ')[0] : 'Not selected'}",
                ),
                SizedBox(height: 10),
                Text(
                  "Selected Items: ${selectedStockItems.isNotEmpty ? selectedStockItems.map((item) => item.name).join(', ') : 'Not selected'}",
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
                if (selectedCustomer == null || selectedDate == null) {
                  return;
                }

                double totalAmount = calculateTotalAmount();

                Invoice newInvoice = Invoice(
                  customer: selectedCustomer!,
                  items: selectedStockItems,
                  date: selectedDate!,
                  amount: totalAmount,
                );

                setState(() {
                  invoices.add(newInvoice);
                });

                itemsController.clear();

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Invoice added successfully'),
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

  void _selectStockItems() {
    List<StockItem> updatedSelectedStockItems = List.from(selectedStockItems);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Items"),
          content: SingleChildScrollView(
            child: Column(
              children: stockItems
                  .map(
                    (item) => CheckboxListTile(
                      title: Text(item.name),
                      value: updatedSelectedStockItems.contains(item),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null) {
                            if (value) {
                              updatedSelectedStockItems.add(item);
                            } else {
                              updatedSelectedStockItems.remove(item);
                            }
                          }
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  selectedStockItems = updatedSelectedStockItems;
                });
                Navigator.of(context).pop();
              },
              child: Text("Done"),
            ),
          ],
        );
      },
    );
  }

  void deleteInvoice(int invoiceId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this invoice?"),
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
                  invoices.removeWhere((invoice) => invoice.id == invoiceId);
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

  void editInvoice(Invoice invoice) {
    selectedCustomer = invoice.customer;
    itemsController.text = invoice.items.first.name;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Invoice"),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                DropdownButton<Customer>(
                  value: selectedCustomer,
                  onChanged: (Customer? value) {
                    setState(() {
                      selectedCustomer = value;
                    });
                  },
                  items: customers
                      .map<DropdownMenuItem<Customer>>((Customer customer) {
                    return DropdownMenuItem<Customer>(
                      value: customer,
                      child: Text(customer.name),
                    );
                  }).toList(),
                ),
                TextField(
                  controller: itemsController,
                  decoration: InputDecoration(labelText: "Items"),
                ),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: TextEditingController(
                        text: selectedDate != null
                            ? "${selectedDate!.toLocal()}".split(' ')[0]
                            : "",
                      ),
                      decoration: InputDecoration(labelText: "Date"),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _selectStockItems();
                  },
                  child: Text("Select Items"),
                ),
                SizedBox(height: 10),
                Text(
                  "Selected Date: ${selectedDate != null ? selectedDate!.toLocal().toString().split(' ')[0] : 'Not selected'}",
                ),
                SizedBox(height: 10),
                Text(
                  "Selected Items: ${selectedStockItems.isNotEmpty ? selectedStockItems.map((item) => item.name).join(', ') : 'Not selected'}",
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
                if (selectedCustomer == null || selectedDate == null) {
                  return;
                }

                double totalAmount = calculateTotalAmount();

                Invoice updatedInvoice = Invoice(
                  customer: selectedCustomer!,
                  items: selectedStockItems,
                  date: selectedDate!,
                  amount: totalAmount,
                );

                setState(() {
                  int index = invoices.indexOf(invoice);
                  if (index != -1) {
                    invoices[index] = updatedInvoice;
                  }
                });

                itemsController.clear();

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Invoice updated successfully'),
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
        title: Text('Invoices Management'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: addInvoice,
            child: Text("Add new invoice"),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Invoice ${invoices[index].id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Customer: ${invoices[index].customer.name}'),
                      Text(
                          'Items: ${invoices[index].items.map((item) => item.name).join(', ')}'),
                      Text('Date: ${invoices[index].date}'),
                      Text('Amount: ${invoices[index].amount}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editInvoice(invoices[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteInvoice(invoices[index].id);
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
