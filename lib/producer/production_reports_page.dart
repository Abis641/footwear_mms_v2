import 'package:flutter/material.dart';
import '../core/services/dummy_data.dart';

class ProductionReportsPage extends StatelessWidget {
  const ProductionReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final total = DummyData.productionPlans.length;
    final completed = DummyData.productionPlans
        .where((p) => p.status == 'Completed')
        .length;

    return Scaffold(
      appBar: AppBar(title: const Text('Production Reports')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Total Plans: $total'),
            Text('Completed Plans: $completed'),
          ],
        ),
      ),
    );
  }
}
