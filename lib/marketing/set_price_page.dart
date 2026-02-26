import 'package:flutter/material.dart';
import '../core/services/dummy_data.dart';

class SetPricePage extends StatefulWidget {
  const SetPricePage({super.key});

  @override
  State<SetPricePage> createState() => _SetPricePageState();
}

class _SetPricePageState extends State<SetPricePage> {
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Selling Prices')),
      body: ListView.builder(
        itemCount: DummyData.products.length,
        itemBuilder: (context, index) {
          final product = DummyData.products[index];

          return ListTile(
            title: Text(product.name),
            subtitle: Text('Current price: ${product.price ?? "Not set"}'),
            trailing: ElevatedButton(
              child: const Text('Set Price'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Set price for ${product.name}'),
                    content: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            product.price =
                                double.parse(priceController.text);
                          });
                          priceController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Save'),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
