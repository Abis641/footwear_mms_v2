import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../producer/producer_dashboard.dart';
import '../supplier/supplier_dashboard.dart';
import '../marketing/marketing_dashboard.dart';
import '../auth/login_screen.dart';

class RoleGate extends StatelessWidget {
  const RoleGate({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const LoginScreen();
    }

    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      builder: (context, snapshot) {
        // 🔄 Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ❌ No data
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(
            body: Center(child: Text("User data not found")),
          );
        }

        final data = snapshot.data!;
        final bool approved = data['approved'] ?? false;
        final String role = data['role'] ?? '';

        // 🚫 Not approved
        if (!approved) {
          return const Scaffold(
            body: Center(
              child: Text(
                "Wait for admin approval",
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        }

        // 🎯 Role Navigation
        switch (role) {
          case 'producer':
            return const ProducerDashboard();

          case 'supplier':
            return const SupplierDashboard();

          case 'marketing':
            return const MarketingDashboard();

          default:
            return const Scaffold(
              body: Center(
                child: Text("Role not assigned"),
              ),
            );
        }
      },
    );
  }
}
