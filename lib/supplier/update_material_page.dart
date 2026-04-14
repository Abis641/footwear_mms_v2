import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateMaterialPage extends StatefulWidget {
  final String id;
  final String name;
  final int quantity;

  const UpdateMaterialPage({
    super.key,
    required this.id,
    required this.name,
    required this.quantity,
  });

  @override
  State<UpdateMaterialPage> createState() => _UpdateMaterialPageState();
}

class _UpdateMaterialPageState extends State<UpdateMaterialPage> {
  late TextEditingController nameController;
  late TextEditingController qtyController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    qtyController =
        TextEditingController(text: widget.quantity.toString());
  }

  Future<void> updateMaterial() async {
    await FirebaseFirestore.instance
        .collection('materials')
        .doc(widget.id)
        .update({
      'name': nameController.text,
      'quantity': int.parse(qtyController.text),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Material')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController),
            const SizedBox(height: 10),
            TextField(
              controller: qtyController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateMaterial,
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}