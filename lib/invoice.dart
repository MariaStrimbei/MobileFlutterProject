import 'stock_item.dart';
import 'customer.dart';

class Invoice {
  static int lastId = 0;
  int id;

  Customer customer;
  List<StockItem> items;
  DateTime date;
  double amount;

  Invoice({
    required this.customer,
    required this.items,
    required this.date,
    required this.amount,
  }) : id = ++lastId;
}
