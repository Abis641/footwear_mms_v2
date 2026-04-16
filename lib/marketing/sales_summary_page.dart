import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SalesSummaryPage extends StatelessWidget {
  const SalesSummaryPage({super.key});

  Future<void> updateSold(String id, int sold, int total) async {
    if (sold < 0 || sold > total) return;

    await FirebaseFirestore.instance
        .collection('production_plans')
        .doc(id)
        .update({'sold': sold});
  }

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
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!.docs;
          double totalRevenue = 0;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final p = products[index];

                    int total = p['quantity'];
                    int sold = p.data().containsKey('sold') ? p['sold'] : 0;
                    int onHand = total - sold;

                    double price =
                        p.data().containsKey('price') ? p['price'] : 0;

                    totalRevenue += sold * price;

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p['product'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("Total: $total"),
                            Text("On Hand: $onHand"),
                            Text("Sold: $sold"),
                            Text("Price: $price"),

                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    updateSold(p.id, sold - 1, total);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    updateSold(p.id, sold + 1, total);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // TOTAL REVENUE
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Total Revenue: \$${totalRevenue.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
