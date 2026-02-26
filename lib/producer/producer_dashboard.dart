import 'package:flutter/material.dart';
import 'production_plan_page.dart';
import 'production_reports_page.dart';
import 'production_status_page.dart';
class ProducerDashboard extends StatelessWidget {
  const ProducerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Producer Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
        
        ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProductionPlanPage()),
    );
  },
  child: const Text('Create Production Plan'),
),

         ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProductionStatusPage()),
    );
  },
  child: const Text('View Production Status'),
),

ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProductionReportsPage()),
    );
  },
  child: const Text('Production Reports'),
),

        ],
      ),
    );
  }
}
