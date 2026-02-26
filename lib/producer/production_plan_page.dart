import 'package:flutter/material.dart';
import '../core/models/production_plan.dart';
import '../core/services/dummy_data.dart';

class ProductionPlanPage extends StatefulWidget {
  const ProductionPlanPage({super.key});

  @override
  State<ProductionPlanPage> createState() => _ProductionPlanPageState();
}

class _ProductionPlanPageState extends State<ProductionPlanPage> {
  final TextEditingController productController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  void savePlan() {
    if (productController.text.isEmpty ||
        quantityController.text.isEmpty) {
      return;
    }

    DummyData.productionPlans.add(
      ProductionPlan(
        id: DateTime.now().toString(),
        productName: productController.text,
        quantity: int.parse(quantityController.text),
        status: 'Planned',
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Production Plan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: productController,
              decoration:
                  const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Quantity'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: savePlan,
              child: const Text('Save Production Plan'),
            ),
          ],
        ),
      ),
    );
  }
}
