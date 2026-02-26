import 'package:flutter/material.dart';

class MarketingCampaignPage extends StatelessWidget {
  const MarketingCampaignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marketing Campaigns')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Active Campaigns',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListTile(
              title: Text('Discount on Men Shoes'),
              subtitle: Text('10% discount this month'),
            ),
            ListTile(
              title: Text('Boots Promotion'),
              subtitle: Text('Buy 1 get 1 half price'),
            ),
          ],
        ),
      ),
    );
  }
}
