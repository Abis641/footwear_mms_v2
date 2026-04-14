import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AddMaterialPage extends StatefulWidget {
  const AddMaterialPage({super.key});

  @override
  State<AddMaterialPage> createState() => _AddMaterialPageState();
}

class _AddMaterialPageState extends State<AddMaterialPage> {
  final nameController = TextEditingController();
  final qtyController = TextEditingController();
  bool isLoading = false;

  Future<void> addMaterial() async {
    if (nameController.text.isEmpty || qtyController.text.isEmpty) return;

    setState(() => isLoading = true);

    await FirebaseFirestore.instance.collection('materials').add({
      'name': nameController.text.trim(),
      'quantity': int.parse(qtyController.text),
      'createdAt': Timestamp.now(),
    });

    setState(() => isLoading = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Material')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Material Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: qtyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: addMaterial,
                    child: const Text("Save"),
                  ),
          ],
        ),
      ),
    );
  }
}