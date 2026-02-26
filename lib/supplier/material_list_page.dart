import 'package:flutter/material.dart';
import '../core/services/dummy_data.dart';

class MaterialListPage extends StatelessWidget {
  const MaterialListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final materials = DummyData.materials;

    return Scaffold(
      appBar: AppBar(title: const Text('Raw Materials')),
      body: ListView.builder(
        itemCount: materials.length,
        itemBuilder: (context, index) {
          final material = materials[index];
          return ListTile(
            title: Text(material.name),
            trailing: Text('Qty: ${material.quantity}'),
          );
        },
      ),
    );
  }
}
