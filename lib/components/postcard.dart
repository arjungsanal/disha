import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String userName;
  final String postTime;
  final String imageUrl;
  final String caption;
  final String latestComment;

  const PostCard({
    super.key,
    required this.userName,
    required this.postTime,
    required this.imageUrl,
    required this.caption,
    this.latestComment = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(255, 255, 255, 0.9), // Light white
            Color.fromRGBO(245, 245, 245, 0.9), // Light grey
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            blurRadius: 10,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header (User Info)
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(
              postTime,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.deepPurple),
              onPressed: () {
                // Handle post options
              },
            ),
          ),
          // Post Image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          // Post Actions (Like, Comment, Share)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.deepPurple),
                  onPressed: () {
                    // Handle like action
                  },
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.comment, color: Colors.deepPurple),
                  onPressed: () {
                    // Handle comment action
                  },
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.deepPurple),
                  onPressed: () {
                    // Handle share action
                  },
                ),
              ],
            ),
          ),
          // Post Caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              caption,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
          // Latest Comment Preview
          if (latestComment.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Latest comment: $latestComment',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}