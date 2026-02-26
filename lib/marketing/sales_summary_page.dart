import 'package:flutter/material.dart';
import '../core/services/dummy_data.dart';

class SalesSummaryPage extends StatelessWidget {
  const SalesSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final totalProducts = DummyData.products.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Sales Summary')),
      body: Center(
        child: Text(
          'Available Products: $totalProducts',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
