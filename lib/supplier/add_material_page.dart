import 'package:flutter/material.dart';
import '../core/services/dummy_data.dart';
import '../core/models/material_model.dart';

class AddMaterialPage extends StatefulWidget {
  const AddMaterialPage({super.key});

  @override
  State<AddMaterialPage> createState() => _AddMaterialPageState();
}

class _AddMaterialPageState extends State<AddMaterialPage> {
  final nameController = TextEditingController();
  final qtyController = TextEditingController();
void addMaterial() {
  DummyData.materials.add(
    MaterialModel(
      id: DateTime.now().toString(),
      name: nameController.text,
      quantity: int.parse(qtyController.text),
    ),
  );

  Navigator.pop(context);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Raw Material')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Material Name'),
            ),
            TextField(
              controller: qtyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addMaterial,
              child: const Text('Save Material'),
            ),
          ],
        ),
      ),
    );
  }
}
