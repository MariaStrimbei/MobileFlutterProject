import 'package:flutter/material.dart';
import 'package:project_ma/manage_stock_page.dart';
import 'package:project_ma/stock_item.dart';
import 'customer.dart';
import 'manage_customers.dart';
import 'warehouse.dart';
import 'manage_warehouses.dart';
import 'invoice.dart';
import 'manage_invoices_page.dart';

List<StockItem> stockItems = [];
List<Customer> customers = [];
List<Warehouse> warehouses = [];
List<Invoice> invoices = [];

void initialPopulate() {
  StockItem newItem1 = StockItem(
    name: "Caramida",
    category: "Roofing and Siding",
    quantity: 10,
    price: 3.5,
    warehouse: "Warehouse A",
  );
  StockItem newItem2 = StockItem(
    name: "Priza A24",
    category: "Electrical",
    quantity: 15,
    price: 3.5,
    warehouse: "Warehouse B",
  );
  StockItem newItem3 = StockItem(
    name: "Gresie",
    category: "Flooring",
    quantity: 20,
    price: 3.5,
    warehouse: "Warehouse A",
  );
  stockItems.add(newItem1);
  stockItems.add(newItem2);
  stockItems.add(newItem3);

  Customer newCustomer1 = Customer(
      name: 'Ana Popa',
      phoneNumber: '0772546789',
      address: 'Strada Florilor',
      taxNumber: '15876502');
  Customer newCustomer2 = Customer(
    name: 'Ion Ionescu',
    phoneNumber: '0765321987',
    address: 'Bulevardul Victoriei',
    taxNumber: '23567890',
  );
  Customer newCustomer3 = Customer(
    name: 'Maria Radu',
    phoneNumber: '0754123678',
    address: 'Aleea Plopilor',
    taxNumber: '19876543',
  );
  customers.add(newCustomer1);
  customers.add(newCustomer2);
  customers.add(newCustomer3);
}

void main() {
  //add initial data into table
  initialPopulate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Building store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Welcome back!"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Admin Interface',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]),
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageStockPage(),
                    ),
                  );
                },
                icon: Icon(Icons.storage),
                label: Text('Manage Stock'),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageCustomersPage(),
                    ),
                  );
                },
                icon: Icon(Icons.people),
                label: Text('Manage Customers'),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageWarehousesPage(),
                    ),
                  );
                },
                icon: Icon(Icons.home_work),
                label: Text('Manage Warehouses'),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageInvoicesPage(),
                    ),
                  );
                },
                icon: Icon(Icons.receipt),
                label: Text('Manage Invoices'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
