import 'package:flutter/material.dart';
import 'add_material_page.dart';
import 'material_list_page.dart';
import 'material_requests_page.dart';
import 'supply_history_page.dart';

class SupplierDashboard extends StatelessWidget {
  const SupplierDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Supplier Dashboard")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Add Material"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddMaterialPage()),
            ),
          ),
          ListTile(
            title: const Text("View Materials"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MaterialListPage()),
            ),
          ),
          ListTile(
            title: const Text("Material Requests"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MaterialRequestsPage()),
            ),
          ),
          ListTile(
            title: const Text("Supply History"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SupplyHistoryPage()),
            ),
          ),
        ],
      ),
    );
  }
}