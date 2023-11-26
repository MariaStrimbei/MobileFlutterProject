import 'stock_item.dart';

class Warehouse {
  int id;
  String name;
  String location;
  List<StockItem> stockItems;

  Warehouse({
    required this.id,
    required this.name,
    required this.location,
    this.stockItems = const [],
  });
}
