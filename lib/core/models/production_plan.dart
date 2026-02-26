class ProductionPlan {
  final String id;
  final String productName;
  final int quantity;
  final String status;

  ProductionPlan({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.status,
  });

  ProductionPlan copyWith({String? status}) {
    return ProductionPlan(
      id: id,
      productName: productName,
      quantity: quantity,
      status: status ?? this.status,
    );
  }
}
