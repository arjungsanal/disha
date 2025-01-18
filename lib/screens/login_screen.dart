import 'package:disha/constant/typography.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserLoginScreen extends StatefulWidget {
  UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final _scrollController = ScrollController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false; // Track loading state

  // Function to handle sign-in
  Future<void> _signIn(BuildContext context) async {
    setState(() {
      _isLoading = true; // Start loading
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      setState(() {
        _isLoading = false; // Stop loading
      });
      return;
    }

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Navigate to the home screen or another screen after successful sign-in
        Navigator.pushReplacementNamed(context, 'userHome_screen');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in failed: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(59, 7, 142, 0.8), // Lighter purple
                Color.fromRGBO(103, 13, 247, 0.898), // Darker purple
              ],
            ),
          ),
          child: Column(
            children: [
              // Back Button and "Don't have an account?" Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Button
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context); // Go back to the previous screen
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    // "Don't have an account?" and Sign Up Button
                    Row(
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: CustomStyle.Light.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Glass-like Sign Up Button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2), // Low opacity white background
                            borderRadius: BorderRadius.circular(8), // Rounded corners
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                               Navigator.pushNamed(context, 'usersignin_screen');
                              // Navigate to the sign-up screen
                              Navigator.pushReplacementNamed(context, 'userSignup_screen');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent, // Transparent background
                              elevation: 0, // Remove shadow
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Rounded corners
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Sign Up",
                                style: CustomStyle.Medium.copyWith(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              // App Title
              Text(
                'Disha',
                style: CustomStyle.TitleText.copyWith(
                  color: Colors.white,
                  fontSize: 60,
                  height: 0,
                ),
              ),
              const SizedBox(height: 70),
              // White container with rounded top corners
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40), // Rounded top-left corner
                    topRight: Radius.circular(40), // Rounded top-right corner
                  ),
                  child: Container(
                    width: double.maxFinite,
                    color: Colors.white, // White background
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: 27,
                      ),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            // Add your content here
                            const SizedBox(height: 20),
                            Text(
                              'Welcome Back',
                              style: CustomStyle.Medium.copyWith(
                                fontSize: 26,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Sign in to continue",
                              style: CustomStyle.Light.copyWith(
                                fontSize: 17,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Email Field
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300, // Light gray border
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300, // Light gray border
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(103, 13, 247, 0.898), // Purple border when focused
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Password Field
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300, // Light gray border
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300, // Light gray border
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(103, 13, 247, 0.898), // Purple border when focused
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Sign In Button with Gradient
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromRGBO(59, 7, 142, 0.8), // Lighter purple
                                    Color.fromRGBO(103, 13, 247, 0.898), // Darker purple
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ElevatedButton(
                                onPressed: _isLoading
                                    ? null // Disable button when loading
                                    : () {
                                        _signIn(context);
                                      },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.transparent, // Transparent background
                                  elevation: 0, // Remove shadow
                                ),
                                child: _isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white, // Loader color
                                      )
                                    : Text(
                                        "Sign In",
                                        style: CustomStyle.Medium.copyWith(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
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