class Customer {
  static int lastId = 0;
  int id;
  String name;
  String phoneNumber;
  String address;
  String taxNumber;

  Customer({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.taxNumber,
  }) : id = ++lastId;
}
