

class StockItem {
  static int lastId = 0;
  int id;
  String name;
  int quantity;
  double price;
  String category;
  String warehouse;

  StockItem(
      {required this.name,
      required this.quantity,
      required this.price,
      required this.category,
      required this.warehouse})
      : id = ++lastId;
}
