import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarketingCampaignPage extends StatefulWidget {
  const MarketingCampaignPage({super.key});

  @override
  State<MarketingCampaignPage> createState() =>
      _MarketingCampaignPageState();
}

class _MarketingCampaignPageState extends State<MarketingCampaignPage> {
  final campaignController = TextEditingController();

  Future<void> createCampaign() async {
    if (campaignController.text.isEmpty) return;

    await FirebaseFirestore.instance.collection('campaigns').add({
      'name': campaignController.text,
      'createdAt': Timestamp.now(),
    });

    campaignController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Marketing Campaigns")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: campaignController,
              decoration: const InputDecoration(
                labelText: "Campaign Name",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: createCampaign,
            child: const Text("Create Campaign"),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('campaigns')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final campaigns = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: campaigns.length,
                  itemBuilder: (context, index) {
                    final c = campaigns[index];
                    return ListTile(title: Text(c['name']));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}