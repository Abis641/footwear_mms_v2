import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class ProductionPlanPage extends StatefulWidget {
  const ProductionPlanPage({super.key});

  @override
  State<ProductionPlanPage> createState() => _ProductionPlanPageState();
}

class _ProductionPlanPageState extends State<ProductionPlanPage> {
  final productController = TextEditingController();
  final qtyController = TextEditingController();
  final materialController = TextEditingController();

  Future<void> createPlan() async {
    if (productController.text.isEmpty ||
        qtyController.text.isEmpty ||
        materialController.text.isEmpty) return;

    // 1. Save production plan
    await FirebaseFirestore.instance.collection('production_plans').add({
      'product': productController.text,
      'quantity': int.parse(qtyController.text),
      'status': 'Planned',
      'createdAt': Timestamp.now(),
    });

    // 2. Create material request (THIS CONNECTS TO SUPPLIER 🔥)
    await FirebaseFirestore.instance.collection('requests').add({
      'material': materialController.text,
      'quantity': int.parse(qtyController.text),
      'status': 'pending',
      'createdAt': Timestamp.now(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Production Plan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: productController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: qtyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: materialController,
              decoration:
                  const InputDecoration(labelText: 'Required Material'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: createPlan,
              child: const Text("Create Plan"),
            ),
          ],
        ),
      ),
    );
  }
}