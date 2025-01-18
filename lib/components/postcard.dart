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
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info (Top Row)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
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
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      postTime,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.black54),
                  onPressed: () {
                    // Handle post options
                  },
                ),
              ],
            ),
          ),
          // Post Image (Full Width)
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          // Action Buttons (Like, Comment, Share)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.black87),
                  onPressed: () {
                    // Handle like action
                  },
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.comment, color: Colors.black87),
                  onPressed: () {
                    // Handle comment action
                  },
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.black87),
                  onPressed: () {
                    // Handle share action
                  },
                ),
              ],
            ),
          ),
          // Caption
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