import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/login_screen.dart';
import 'add_material_page.dart';
import 'material_list_page.dart';
import 'material_requests_page.dart';
import 'supply_history_page.dart';

class SupplierDashboard extends StatelessWidget {
  const SupplierDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supplier Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _buildCard(
            context,
            title: "Add Material",
            icon: Icons.add_circle,
            page: const AddMaterialPage(),
          ),
          _buildCard(
            context,
            title: "View Materials",
            icon: Icons.list,
            page: const MaterialListPage(),
          ),
          _buildCard(
            context,
            title: "Material Requests",
            icon: Icons.request_page,
            page: const MaterialRequestsPage(),
          ),
          _buildCard(
            context,
            title: "Supply History",
            icon: Icons.history,
            page: const SupplyHistoryPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget page,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        ),
      ),
    );
  }
}
