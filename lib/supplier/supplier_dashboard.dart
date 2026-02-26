import 'package:flutter/material.dart';
import 'material_list_page.dart';
import 'add_material_page.dart';
import 'update_material_page.dart';
import 'supply_history_page.dart';
import 'material_requests_page.dart';
class SupplierDashboard extends StatelessWidget {
  const SupplierDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supplier Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MaterialListPage()),
    );
  },
  child: const Text('Registered Raw Materials'),
),
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddMaterialPage()),
    );
  },
  child: const Text('Add Raw Material'),
),

      ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const UpdateMaterialPage()),
    );
  },
  child: const Text('Update Material Availability'),
),

ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MaterialRequestsPage()),
    );
  },
  child: const Text('View Material Requests'),
),

       ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SupplyHistoryPage()),
    );
  },
  child: const Text('Supply History'),
),

        ],
      ),
    );
  }
}
