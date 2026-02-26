import 'package:flutter/material.dart';

class MaterialRequestsPage extends StatelessWidget {
  const MaterialRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Material Requests')),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Leather'),
            subtitle: Text('Requested: 50 units'),
            trailing: Text('Approved'),
          ),
          ListTile(
            title: Text('Rubber Sole'),
            subtitle: Text('Requested: 30 units'),
            trailing: Text('Pending'),
          ),
        ],
      ),
    );
  }
}
