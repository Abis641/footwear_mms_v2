import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MaterialRequestsPage extends StatelessWidget {
  const MaterialRequestsPage({super.key});

  Future<void> updateRequest(String id, bool approve) async {
    await FirebaseFirestore.instance
        .collection('requests')
        .doc(id)
        .update({'status': approve ? 'approved' : 'rejected'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Material Requests')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('requests')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final requests = snapshot.data!.docs;

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final r = requests[index];

              return ListTile(
                title: Text(r['material']),
                subtitle: Text("Qty: ${r['quantity']}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => updateRequest(r.id, true),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => updateRequest(r.id, false),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}