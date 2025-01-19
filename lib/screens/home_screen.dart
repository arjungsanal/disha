import 'package:disha/components/postcard.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeSection extends StatefulWidget {
  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _posts = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  // Fetch posts from Supabase
  Future<void> _fetchPosts() async {
    try {
      final response = await _supabase
          .from('posts')
          .select('*')
          .order('created_at', ascending: false);

      setState(() {
        _posts = List<Map<String, dynamic>>.from(response);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load posts. Please try again later.';
        _isLoading = false;
      });
      print('Error fetching posts: $e');
    }
  }

  // Function to handle refresh
  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = true;
    });
    await _fetchPosts();
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
                    if (_isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    } else if (_errorMessage.isNotEmpty) {
                      return Center(
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      );
                    } else if (_posts.isEmpty) {
                      return const Center(
                        child: Text(
                          'No posts available.',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      );
                    }

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
                  childCount: _isLoading || _errorMessage.isNotEmpty || _posts.isEmpty
                      ? 1
                      : _posts.length,
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Handle create post action
      //   },
      //   backgroundColor: Colors.deepPurple, // Deep purple FAB
      //   child: const Icon(Icons.add, color: Colors.white),
      // ),
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