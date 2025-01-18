import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current user from Supabase
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display user data
              if (user != null) ...[
                Text(
                  "Welcome, ${user.email ?? 'User'}!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "User ID: ${user.id}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Email: ${user.email}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Name: ${user.userMetadata?['name'] ?? 'Not provided'}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ] else ...[
                Text(
                  "No user logged in.",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              const SizedBox(height: 30),
              // Logout button
              ElevatedButton(
                onPressed: () async {
                  // Sign out the user
                  await Supabase.instance.client.auth.signOut();
                  // Navigate back to the sign-in screen
                  Navigator.pushReplacementNamed(context, '/signin');
                },
                child: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}