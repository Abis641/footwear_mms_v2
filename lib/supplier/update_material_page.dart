import 'package:flutter/material.dart';
import '../core/services/dummy_data.dart';
import '../core/models/material_model.dart';

class UpdateMaterialPage extends StatefulWidget {
  const UpdateMaterialPage({super.key});

  @override
  State<UpdateMaterialPage> createState() => _UpdateMaterialPageState();
}

class _UpdateMaterialPageState extends State<UpdateMaterialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Material Availability')),
      body: ListView.builder(
        itemCount: DummyData.materials.length,
        itemBuilder: (context, index) {
          final material = DummyData.materials[index];
          return Card(
            child: ListTile(
              title: Text(material.name),
              subtitle: Text('Quantity: ${material.quantity}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  setState(() {
                    DummyData.materials[index] = MaterialModel(
                      id: material.id,
                      name: material.name,
                      quantity: material.quantity + 10,
                    );
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
