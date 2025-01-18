import 'package:disha/components/postcard.dart';
import 'package:flutter/material.dart';

class HomeSection extends StatefulWidget {
  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  // Dummy data for posts
  final List<Map<String, dynamic>> _posts = [
    {
      'user': {'email': 'user1@example.com'},
      'created_at': '2023-10-01T12:00:00Z',
      'image_url': 'https://imgs.search.brave.com/Bw8VO770wFId17goUnaahxxZSVWDelmTD78yeZovt-k/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzAyLzEwLzUwLzQ0/LzM2MF9GXzIxMDUw/NDQ3Ml9IekM2M3Nl/RWo3cW9iSm1rcm15/Ym5ZQkFMUDJRRmdk/TS5qcGc',
      'caption': 'This is a dummy post 1',
    },
    {
      'user': {'email': 'user2@example.com'},
      'created_at': '2023-10-02T14:30:00Z',
      'image_url': 'https://imgs.search.brave.com/p6x_e4qGegSm2pi2Fs64QYPEAg9H9ldODp-LYOiuw9Q/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzAyLzk0LzMwLzAw/LzM2MF9GXzI5NDMw/MDA2OV9rS3F1ZEVZ/dEM2QmtLSFk3TzFq/UTA1V2NVUHJDOGhI/aS5qcGc',
      'caption': 'This is a dummy post 2',
    },
    {
      'user': {'email': 'user3@example.com'},
      'created_at': '2023-10-03T09:15:00Z',
      'image_url': 'https://imgs.search.brave.com/cE-hkf7uBeeNvrEa8PTHZ3sg4omvPmn32p3ow5A8zvw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jb2lu/c3RhdGljcy5jb20v/d3AtY29udGVudC91/cGxvYWRzLzIwMTgv/MDMvUm9iZXJ0LURv/d25leS1Kci4tUXVv/dGVzLmpwZw',
      'caption': 'This is a dummy post 3',
    },
  ];

  // Function to handle refresh
  Future<void> _onRefresh() async {
    // Simulate a network call to fetch new posts
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      // Update the posts list (e.g., fetch new data from an API)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple, // Deep purple
              Colors.purpleAccent, // Purple accent
            ],
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
            slivers: [
              // AppBar with Glassmorphism Effect
              SliverAppBar(
                title: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.white.withOpacity(0.2),
                elevation: 0,
                floating: true,
                snap: true,
                automaticallyImplyLeading: false, // Remove back button
              ),
              // Posts List
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final post = _posts[index];
                    final user = post['user'] as Map<String, dynamic>?; // User details
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white, // White card background
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: PostCard(
                        userName: user?['email'] ?? 'Unknown User',
                        postTime: _getPostTime(post['created_at']),
                        imageUrl: post['image_url'],
                        caption: post['caption'],
                        latestComment: 'Great post!',
                      ),
                    );
                  },
                  childCount: _posts.length,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle create post action
        },
        backgroundColor: Colors.deepPurple, // Deep purple FAB
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Helper function to calculate post time
  String _getPostTime(String? createdAt) {
    if (createdAt == null) return 'Just now';

    final postTime = DateTime.parse(createdAt);
    final now = DateTime.now();
    final difference = now.difference(postTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}