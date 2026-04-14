import 'package:flutter/material.dart';
import 'product_list_page.dart';
import 'set_price_page.dart';
import 'marketing_campaign_page.dart';
import 'sales_summary_page.dart';

class MarketingDashboard extends StatelessWidget {
  const MarketingDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Marketing Dashboard")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("View Products"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProductListPage()),
            ),
          ),
          ListTile(
            title: const Text("Set Product Price"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SetPricePage()),
            ),
          ),
          ListTile(
            title: const Text("Marketing Campaign"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MarketingCampaignPage()),
            ),
          ),
          ListTile(
            title: const Text("Sales Summary"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SalesSummaryPage()),
            ),
          ),
        ],
      ),
    );
  }
}