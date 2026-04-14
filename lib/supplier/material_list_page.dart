import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'update_material_page.dart';

class MaterialListPage extends StatelessWidget {
  const MaterialListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Materials')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('materials')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final materials = snapshot.data!.docs;

          if (materials.isEmpty) {
            return const Center(child: Text("No materials found"));
          }

          return ListView.builder(
            itemCount: materials.length,
            itemBuilder: (context, index) {
              final m = materials[index];

              return ListTile(
                title: Text(m['name']),
                subtitle: Text("Qty: ${m['quantity']}"),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UpdateMaterialPage(
                          id: m.id,
                          name: m['name'],
                          quantity: m['quantity'],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}