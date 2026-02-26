import 'package:flutter/material.dart';
import '../core/services/dummy_data.dart';
import '../core/models/product.dart';

class ProductionStatusPage extends StatefulWidget {
  const ProductionStatusPage({super.key});

  @override
  State<ProductionStatusPage> createState() => _ProductionStatusPageState();
}

class _ProductionStatusPageState extends State<ProductionStatusPage> {
  void updateStatus(int index) {
    setState(() {
      final plan = DummyData.productionPlans[index];

      if (plan.status == 'Planned') {
        DummyData.productionPlans[index] =
            plan.copyWith(status: 'In Progress');
      } else if (plan.status == 'In Progress') {
        DummyData.productionPlans[index] =
            plan.copyWith(status: 'Completed');

        DummyData.products.add(
          Product(
            id: DateTime.now().toString(),
            name: plan.productName,
            quantity: plan.quantity,
            isAvailable: true,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final plans = DummyData.productionPlans;

    return Scaffold(
      appBar: AppBar(title: const Text('Production Status')),
      body: plans.isEmpty
          ? const Center(child: Text('No production plans yet'))
          : ListView.builder(
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final plan = plans[index];
                return Card(
                  child: ListTile(
                    title: Text(plan.productName),
                    subtitle: Text(
                        'Qty: ${plan.quantity} | Status: ${plan.status}'),
                    trailing: plan.status != 'Completed'
                        ? ElevatedButton(
                            onPressed: () => updateStatus(index),
                            child: const Text('Next Status'),
                          )
                        : const Icon(Icons.check, color: Colors.green),
                  ),
                );
              },
            ),
    );
  }
}
