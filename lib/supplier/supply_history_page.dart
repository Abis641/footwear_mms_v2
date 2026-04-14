import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupplyHistoryPage extends StatelessWidget {
  const SupplyHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supply History')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('materials')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final materials = snapshot.data!.docs;

          return ListView.builder(
            itemCount: materials.length,
            itemBuilder: (context, index) {
              final m = materials[index];

              return ListTile(
                title: Text(m['name']),
                subtitle: Text("Qty: ${m['quantity']}"),
              );
            },
          );
        },
      ),
    );
  }
}