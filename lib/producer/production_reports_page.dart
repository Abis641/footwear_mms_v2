import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductionReportsPage extends StatelessWidget {
  const ProductionReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Production Reports')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('production_plans')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final plans = snapshot.data!.docs;

          int total = plans.length;
          int completed =
              plans.where((p) => p['status'] == 'Completed').length;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text("Total Plans: $total")),
              const SizedBox(height: 10),
              Center(child: Text("Completed: $completed")),
            ],
          );
        },
      ),
    );
  }
}