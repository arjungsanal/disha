import 'package:disha/components/postcard.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
 // Import the reusable PostCard

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int _selectedIndex = 0; // Track the selected bottom navigation index

  // Bottom navigation items
  static final List<Widget> _widgetOptions = <Widget>[
    HomeSection(), // Home section
    AddPostSection(), // Add post section
    EventSection(), // Event section
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user from Supabase
    final user = Supabase.instance.client.auth.currentUser;
    final displayName = user?.userMetadata?['display_name'] ?? 'User';
    final displayNameInitial = displayName.isNotEmpty ? displayName[0] : 'U';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Disha',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(59, 7, 142, 0.8), // Lighter purple
                Color.fromRGBO(103, 13, 247, 0.898), // Darker purple
              ],
            ),
          ),
        ),
        actions: [
          // Display the first letter of the user's display name
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(
                displayNameInitial.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(59, 7, 142, 0.8), // Lighter purple
              Color.fromRGBO(103, 13, 247, 0.898), // Darker purple
            ],
          ),
        ),
        child: _widgetOptions[_selectedIndex], // Display the selected section
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Event',
          ),
        ],
      ),
    );
  }
}

// Home Section (Posts Feed)
class HomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Example: 10 posts
      itemBuilder: (context, index) {
        return PostCard (
          userName: 'User $index',
          postTime: '${index + 1} hours ago',
          imageUrl: 'assets/post_image_$index.jpg', // Example image
          caption: 'This is a sample post caption $index. Lorem ipsum dolor sit amet.',
        );
      },
    );
  }
}

// Add Post Section
class AddPostSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Add Post Section',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}

// Event Section
class EventSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Event Section',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}