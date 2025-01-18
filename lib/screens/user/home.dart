import 'package:disha/components/postcard.dart';
import 'package:disha/screens/addpost_screen.dart';
import 'package:disha/screens/event_screen.dart';
import 'package:disha/screens/home_screen.dart';
import 'package:disha/screens/user/group_screen.dart';
import 'package:disha/screens/user/health.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


// Initialize Supabase client
final supabase = Supabase.instance.client;

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
    const GroupScreen(), // Group & Community
    const HealthScreen(), // Health
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Disha',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Roboto', // Use a modern font
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
          // User avatar or profile icon
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: (){
                Navigator.pushNamed(context, 'profile_screen');
              },
              // backgroundColor: Colors.deepPurple,
              icon: const Icon(Icons.person, color: Colors.white),
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
      bottomNavigationBar: Container(
        height: 80, // Increased height to accommodate the FAB
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9), // Semi-transparent white
          borderRadius: BorderRadius.circular(30), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.group, 'Community', 1), // Plus button integrated into the nav bar
            _buildNavItem(Icons.health_and_safety, 'Health', 2),
          ],
        ),
      ),
    );
  }

  // Helper method to build navigation items
  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add a container for the FAB to prevent overflow
          if (index == 1)
            Container(
              width: 50, // Adjusted width
              height: 50, // Adjusted height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), // Rounded corners
                color: _selectedIndex == index ? Colors.deepPurple : Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            )
          else
            Icon(
              icon,
              color: _selectedIndex == index ? Colors.deepPurple : Colors.grey,
              size: 28,
            ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.deepPurple : Colors.grey,
              fontSize: 12,
              fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}



