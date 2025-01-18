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
      'image_url': 'https://imgs.search.brave.com/0ulBnTAZWXlyOwVjp1vKWYKRdbAW7wUYlHOp_6mPa_U/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9kMXYw/eW5sZDV4OTQ5eC5j/bG91ZGZyb250Lm5l/dC9JbWFnZXMvMTU0/NTUvMTA0NTY3Nzdf/aW1hZ2UuanBn',
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
      'image_url': 'https://imgs.search.brave.com/0ulBnTAZWXlyOwVjp1vKWYKRdbAW7wUYlHOp_6mPa_U/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9kMXYw/eW5sZDV4OTQ5eC5j/bG91ZGZyb250Lm5l/dC9JbWFnZXMvMTU0/NTUvMTA0NTY3Nzdf/aW1hZ2UuanBn',
      'caption': 'This is a dummy post 3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        final user = post['user'] as Map<String, dynamic>?; // User details
        return PostCard(
          userName: user?['email'] ?? 'Unknown User', // Display user email
          postTime: _getPostTime(post['created_at']), // Calculate post time
          imageUrl: post['image_url'], // Fetch image URL from dummy data
          caption: post['caption'], // Fetch caption from dummy data
          latestComment: 'Great post!', // Replace with actual comment
        );
      },
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