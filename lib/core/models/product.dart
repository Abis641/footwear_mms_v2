class Product {
  final String id;
  final String name;
  final int quantity;
  final bool isAvailable;
  double? price;
  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.isAvailable,
    this.price,
  });
}
