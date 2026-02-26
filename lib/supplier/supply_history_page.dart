import 'package:flutter/material.dart';
import '../core/services/dummy_data.dart';

class SupplyHistoryPage extends StatelessWidget {
  const SupplyHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supply History')),
      body: ListView.builder(
        itemCount: DummyData.materials.length,
        itemBuilder: (context, index) {
          final material = DummyData.materials[index];
          return ListTile(
            leading: const Icon(Icons.inventory),
            title: Text(material.name),
            subtitle: Text('Quantity: ${material.quantity}'),
          );
        },
      ),
    );
  }
}
