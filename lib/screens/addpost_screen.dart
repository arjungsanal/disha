import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

// Initialize Supabase client
final supabase = Supabase.instance.client;

class AddPostSection extends StatefulWidget {
  const AddPostSection({super.key});

  @override
  State<AddPostSection> createState() => _AddPostSectionState();
}

class _AddPostSectionState extends State<AddPostSection> {
  final TextEditingController _captionController = TextEditingController();
  File? _image;
  bool _isLoading = false;

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to handle posting
  Future<void> _post() async {
    if (_image == null || _captionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add an image and a caption.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Upload image to Supabase Storage
      final filePath = 'posts/${DateTime.now().toIso8601String()}.jpg';
      await supabase.storage
          .from('post_images') // Replace with your bucket name
          .upload(filePath, _image!);

      // Get the public URL of the uploaded image
      final imageUrl = supabase.storage
          .from('post_images')
          .getPublicUrl(filePath);

      // Get the current user's ID
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) {
        throw Exception('User not logged in');
      }

      // Insert post data into the Supabase database
      await supabase.from('posts').insert([
        {
          'caption': _captionController.text,
          'image_url': imageUrl,
          'user_id': userId,
        }
      ]);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post uploaded successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear the form
      setState(() {
        _image = null;
        _captionController.clear();
      });
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading post: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Add Post',
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Image Picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: _image == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                size: 50,
                                color: Colors.deepPurple,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Tap to add an image',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            _image!,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              // Caption Text Field
              TextField(
                controller: _captionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Write a caption...',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Post Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _post,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          'Post',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
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