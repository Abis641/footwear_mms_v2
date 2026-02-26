import 'package:flutter/material.dart';
import 'product_list_page.dart';
import 'sales_summary_page.dart';
import 'set_price_page.dart';
import 'marketing_campaign_page.dart';
class MarketingDashboard extends StatelessWidget {
  const MarketingDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marketing Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
         ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProductListPage()),
    );
  },
  child: const Text('View Available Products'),
),

         ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SetPricePage()),
    );
  },
  child: const Text('Set Selling Prices'),
),

         ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MarketingCampaignPage()),
    );
  },
  child: const Text('Marketing Campaigns'),
),

          ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SalesSummaryPage()),
    );
  },
  child: const Text('Sales Summary'),
),

        ],
      ),
    );
  }
}
