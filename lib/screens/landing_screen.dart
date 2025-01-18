import 'package:disha/constant/typography.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient and main content
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
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Disha',
                    style: CustomStyle.TitleText.copyWith(
                      color: Colors.white,
                      fontSize: 75,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 1), // Reduced space between texts
                  Text(
                    "A new way of life",
                    style: CustomStyle.Bold.copyWith(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 70), // Space before the button
                  // Get Started Button
                  ElevatedButton(
                    onPressed: () {
                      // Add your onPressed logic here
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Slightly rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ), // Sufficient padding
                      backgroundColor: Colors.white, // Background color
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "Get Started",
                        style: CustomStyle.Bold.copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // TextButton positioned at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 50, // Adjust this value to control the distance from the bottom
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'report_screen');
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ), // Button padding
                  side: const BorderSide(
                    color: Colors.white,
                    width: 2,
                  ), // White border
                  backgroundColor: Colors.transparent, // Transparent background
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Slightly rounded corners
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: const Text(
                    "Let Us Know\nanonymously",
                    style: TextStyle(
                      
                      color: Colors.white, // White text color
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}