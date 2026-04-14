import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SalesSummaryPage extends StatelessWidget {
  const SalesSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sales Summary")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('production_plans')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final products = snapshot.data!.docs;

          double totalRevenue = 0;

          for (var p in products) {
            if (p.data().containsKey('price')) {
              totalRevenue += p['price'] * p['quantity'];
            }
          }

          return Center(
            child: Text(
              "Total Revenue: \$${totalRevenue.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}