import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/login_screen.dart';
import 'production_plan_page.dart';
import 'production_status_page.dart';
import 'production_reports_page.dart';

class ProducerDashboard extends StatelessWidget {
  const ProducerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Producer Dashboard"),
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
            title: "Create Production Plan",
            icon: Icons.add_box,
            page: const ProductionPlanPage(),
          ),
          _buildCard(
            context,
            title: "Update Production Status",
            icon: Icons.update,
            page: const ProductionStatusPage(),
          ),
          _buildCard(
            context,
            title: "View Reports",
            icon: Icons.bar_chart,
            page: const ProductionReportsPage(),
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
        leading: Icon(icon, color: Colors.blue),
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
