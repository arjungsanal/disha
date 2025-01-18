import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  User? _currentUser;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  // Fetch the current user from Supabase
  Future<void> _fetchCurrentUser() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      setState(() {
        _currentUser = user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load user data.';
        _isLoading = false;
      });
      print('Error fetching user data: $e');
    }
  }

  // Logout function
  Future<void> _logout() async {
    try {
      await _supabase.auth.signOut();
      print("Profile Done..");
      // Navigate to the login screen after logout using a named route
      Navigator.pushReplacementNamed(context, 'login_screen');
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : _errorMessage.isNotEmpty
                ? Center(
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                : _currentUser == null
                    ? const Center(
                        child: Text(
                          'No user data found.',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profile Picture
                            Center(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // User Info Card
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    // User Name
                                    ListTile(
                                      leading: const Icon(Icons.person,
                                          color: Colors.deepPurple),
                                      title: const Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      subtitle: Text(
                                        _currentUser?.userMetadata?[
                                                    'display_name'] ??
                                            'No Name',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Divider(),

                                    // User Email
                                    ListTile(
                                      leading: const Icon(Icons.email,
                                          color: Colors.deepPurple),
                                      title: const Text(
                                        'Email',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      subtitle: Text(
                                        _currentUser?.email ?? 'No Email',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Divider(),

                                    // Account Creation Date
                                    ListTile(
                                      leading: const Icon(Icons.calendar_today,
                                          color: Colors.deepPurple),
                                      title: const Text(
                                        'Account Created On',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      subtitle: Text(
                                        _currentUser?.createdAt != null
                                            ? DateTime.parse(
                                                    _currentUser!.createdAt!)
                                                .toLocal()
                                                .toString()
                                                .split(' ')[0]
                                            : 'Unknown',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Divider(),

                                    // Provider Type
                                    ListTile(
                                      leading: const Icon(Icons.account_circle,
                                          color: Colors.deepPurple),
                                      title: const Text(
                                        'Login Provider',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      subtitle: Text(
                                        _currentUser?.userMetadata?['user_type'] ??
                                            'Unknown',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Logout Button
                            Center(
                              child: ElevatedButton(
                                onPressed: _logout,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
      ),
    );
  }
}