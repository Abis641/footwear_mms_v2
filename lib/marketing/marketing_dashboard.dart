import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/login_screen.dart';
import 'product_list_page.dart';
import 'set_price_page.dart';
import 'marketing_campaign_page.dart';
import 'sales_summary_page.dart';

class MarketingDashboard extends StatelessWidget {
  const MarketingDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Marketing Dashboard"),
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
            title: "View Products",
            page: const ProductListPage(),
          ),
          _buildCard(
            context,
            title: "Set Product Price",
            page: const SetPricePage(),
          ),
          _buildCard(
            context,
            title: "Marketing Campaign",
            page: const MarketingCampaignPage(),
          ),
          _buildCard(
            context,
            title: "Sales Summary",
            page: const SalesSummaryPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title, required Widget page}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
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
