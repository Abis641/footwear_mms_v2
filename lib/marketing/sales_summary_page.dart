import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SalesSummaryPage extends StatefulWidget {
  const SalesSummaryPage({super.key});

  @override
  State<SalesSummaryPage> createState() => _SalesSummaryPageState();
}

class _SalesSummaryPageState extends State<SalesSummaryPage> {

  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');

  @override
  void initState() {
    super.initState();
    _initializeProducts();
  }

  /// 🔥 Auto-create products collection if empty
  Future<void> _initializeProducts() async {
    final snapshot = await productsRef.get();

    if (snapshot.docs.isEmpty) {
      await productsRef.add({
        'product_name': 'Men Shoes',
        'total': 50,
        'sold': 0,
        'onHand': 50,
        'price': 1500.0,
      });

      await productsRef.add({
        'product_name': 'Boots',
        'total': 30,
        'sold': 0,
        'onHand': 30,
        'price': 2000.0,
      });
    }
  }

  /// ➕ Sell product
  Future<void> increaseSold(DocumentSnapshot doc) async {
    final data = doc.data() as Map<String, dynamic>;

    int sold = data['sold'] ?? 0;
    int onHand = data['onHand'] ?? 0;

    if (onHand > 0) {
      await productsRef.doc(doc.id).update({
        'sold': sold + 1,
        'onHand': onHand - 1,
      });
    }
  }

  /// ➖ Undo sale
  Future<void> decreaseSold(DocumentSnapshot doc) async {
    final data = doc.data() as Map<String, dynamic>;

    int sold = data['sold'] ?? 0;
    int onHand = data['onHand'] ?? 0;

    if (sold > 0) {
      await productsRef.doc(doc.id).update({
        'sold': sold - 1,
        'onHand': onHand + 1,
      });
    }
  }

  double calculateTotalRevenue(List<QueryDocumentSnapshot> docs) {
    double total = 0;

    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      int sold = data['sold'] ?? 0;
      double price = (data['price'] ?? 0).toDouble();

      total += sold * price;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sales Summary"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: productsRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;
          double totalRevenue = calculateTotalRevenue(docs);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    String name = data['product_name'] ?? '';
                    int total = data['total'] ?? 0;
                    int sold = data['sold'] ?? 0;
                    int onHand = data['onHand'] ?? 0;
                    double price = (data['price'] ?? 0).toDouble();

                    double revenue = sold * price;

                    return Card(
                      margin: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),

                            const SizedBox(height: 5),

                            Text("Total: $total"),
                            Text("On Hand: $onHand"),
                            Text("Sold: $sold"),
                            Text("Price: ETB $price"),

                            const SizedBox(height: 5),

                            Text(
                              "Revenue: ETB ${revenue.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),

                            const SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () => decreaseSold(doc),
                                ),
                                const SizedBox(width: 20),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => increaseSold(doc),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// 🔥 TOTAL REVENUE
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Total Revenue: ETB ${totalRevenue.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
