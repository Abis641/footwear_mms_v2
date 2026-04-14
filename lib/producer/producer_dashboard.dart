import 'package:flutter/material.dart';
import 'production_plan_page.dart';
import 'production_status_page.dart';
import 'production_reports_page.dart';

class ProducerDashboard extends StatelessWidget {
  const ProducerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Producer Dashboard")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Create Production Plan"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProductionPlanPage()),
            ),
          ),
          ListTile(
            title: const Text("Update Production Status"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProductionStatusPage()),
            ),
          ),
          ListTile(
            title: const Text("View Reports"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProductionReportsPage()),
            ),
          ),
        ],
      ),
    );
  }
}