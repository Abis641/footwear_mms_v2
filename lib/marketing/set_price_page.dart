import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SetPricePage extends StatelessWidget {
  const SetPricePage({super.key});

  Future<void> setPrice(String id, String price) async {
    await FirebaseFirestore.instance
        .collection('production_plans')
        .doc(id)
        .update({'price': double.parse(price)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Price")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('production_plans')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              final priceController = TextEditingController();

              return ListTile(
                title: Text(p['product']),
                subtitle: Text("Current Price: ${p.data().containsKey('price') ? p['price'] : 'Not set'}"),
                trailing: SizedBox(
                  width: 150,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: "Price"),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.save),
                        onPressed: () {
                          setPrice(p.id, priceController.text);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}