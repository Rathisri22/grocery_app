import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Email: ${user?.email}", style: const TextStyle(fontSize: 18)),
            Text("UID: ${user?.uid}", style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await _auth.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
