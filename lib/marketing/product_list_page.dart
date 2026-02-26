import 'package:flutter/material.dart';
import '../core/services/dummy_data.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Show only available products
    final products =
        DummyData.products.where((p) => p.isAvailable).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Available Products')),
      body: products.isEmpty
          ? const Center(child: Text('No products available'))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Quantity: ${product.quantity}'),
                  trailing: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                );
              },
            ),
    );
  }
}
