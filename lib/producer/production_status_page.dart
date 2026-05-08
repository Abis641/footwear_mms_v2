
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductionStatusPage extends StatelessWidget {
  const ProductionStatusPage({super.key});

  Future<void> updateStatus(String id, String status) async {
    final firestore = FirebaseFirestore.instance;

    // Get production plan document
    final planDoc =
        await firestore.collection('production_plans').doc(id).get();

    if (!planDoc.exists) return;

    final data = planDoc.data() as Map<String, dynamic>;

    // Prevent duplicate completed updates
    if (data['status'] == 'Completed' && status == 'Completed') {
      return;
    }

    // Update production status
    await firestore
        .collection('production_plans')
        .doc(id)
        .update({'status': status});

    // If production completed -> add/update products collection
    if (status == 'Completed') {
      String productName = data['product'] ?? '';
      int quantity = data['quantity'] ?? 0;

      final productsRef = firestore.collection('products');

      // Check if product already exists
      final existingProduct = await productsRef
          .where('product_name', isEqualTo: productName)
          .get();

      if (existingProduct.docs.isNotEmpty) {
        // Update existing product
        final productDoc = existingProduct.docs.first;

        final productData = productDoc.data();

        int currentTotal = productData['total'] ?? 0;
        int currentOnHand = productData['onHand'] ?? 0;

        await productsRef.doc(productDoc.id).update({
          'total': currentTotal + quantity,
          'onHand': currentOnHand + quantity,
        });
      } else {
        // Create new product
        await productsRef.add({
          'product_name': productName,
          'total': quantity,
          'sold': 0,
          'onHand': quantity,
          'price': 0.0,
          'createdAt': Timestamp.now(),
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Production Status'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('production_plans')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // No data
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No Production Plans",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final plans = snapshot.data!.docs;

          return ListView.builder(
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final plan = plans[index];
              final data = plan.data() as Map<String, dynamic>;

              String product = data['product'] ?? '';
              int quantity = data['quantity'] ?? 0;
              String status = data['status'] ?? 'Planned';

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Quantity: $quantity",
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        "Status: $status",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: status == "Completed"
                              ? Colors.green
                              : status == "In Progress"
                                  ? Colors.orange
                                  : Colors.blue,
                        ),
                      ),

                      const SizedBox(height: 15),

                      DropdownButtonFormField<String>(
                        value: status,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "Planned",
                            child: Text("Planned"),
                          ),
                          DropdownMenuItem(
                            value: "In Progress",
                            child: Text("In Progress"),
                          ),
                          DropdownMenuItem(
                            value: "Completed",
                            child: Text("Completed"),
                          ),
                        ],
                        onChanged: (value) async {
                          if (value != null) {
                            await updateStatus(plan.id, value);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Status updated to $value",
                                ),
                              ),
                            );
                          }
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

