import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductionStatusPage extends StatelessWidget {
  const ProductionStatusPage({super.key});

  Future<void> updateStatus(String id, String status) async {
    await FirebaseFirestore.instance
        .collection('production_plans')
        .doc(id)
        .update({'status': status});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Production Status')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('production_plans')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final plans = snapshot.data!.docs;

          return ListView.builder(
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final p = plans[index];

              return ListTile(
                title: Text(p['product']),
                subtitle: Text("Status: ${p['status']}"),
                trailing: DropdownButton<String>(
                  value: p['status'],
                  items: const [
                    DropdownMenuItem(
                        value: "Planned", child: Text("Planned")),
                    DropdownMenuItem(
                        value: "In Progress", child: Text("In Progress")),
                    DropdownMenuItem(
                        value: "Completed", child: Text("Completed")),
                  ],
                  onChanged: (value) {
                    updateStatus(p.id, value!);
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