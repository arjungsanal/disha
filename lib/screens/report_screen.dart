import 'package:disha/constant/typography.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final SupabaseClient supabase = Supabase.instance.client;

  // List of districts in Kerala
  final List<String> districts = const [
    'Thiruvananthapuram',
    'Kollam',
    'Pathanamthitta',
    'Alappuzha',
    'Kottayam',
    'Idukki',
    'Ernakulam',
    'Thrissur',
    'Palakkad',
    'Malappuram',
    'Kozhikode',
    'Wayanad',
    'Kannur',
    'Kasaragod',
  ];

  String? selectedDistrict; // Variable to store the selected district
  final TextEditingController locationController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  bool isLoading = false; // Track loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: BottomNavigationBar(items: items),
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
              const SizedBox(height: 130),
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
                      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                      child: SingleChildScrollView(
                        // Make the content scrollable
                        child: Column(
                          children: [
                            // Add your content here
                            const SizedBox(height: 20),
                            Text(
                              'Let Us know',
                              style: CustomStyle.Medium.copyWith(
                                fontSize: 22,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Your message will be anonymous",
                              style: CustomStyle.Light.copyWith(
                                fontSize: 17,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 30),
                            // District Dropdown
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                hintText: 'Select your District',
                                hintStyle: CustomStyle.Light.copyWith(
                                  fontSize: 16,
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(103, 13, 247, 0.898), // Highlight color when focused
                                    width: 2,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                              value: selectedDistrict,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedDistrict = newValue; // Update the selected district
                                });
                              },
                              items: districts.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 20),
                            // Location TextField
                            TextField(
                              controller: locationController,
                              decoration: InputDecoration(
                                hintText: 'Enter your location',
                                hintStyle: CustomStyle.Light.copyWith(
                                  fontSize: 16,
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(103, 13, 247, 0.898), // Highlight color when focused
                                    width: 2,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Message TextField
                            TextField(
                              controller: messageController,
                              maxLines: 5, // Allow multiple lines for the message
                              decoration: InputDecoration(
                                hintText: 'Enter your message',
                                hintStyle: CustomStyle.Light.copyWith(
                                  fontSize: 16,
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(103, 13, 247, 0.898), // Highlight color when focused
                                    width: 2,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Gradient Submit Button
                            isLoading
                                ? const CircularProgressIndicator() // Show loader
                                : InkWell(
                                    onTap: () async {
                                      if (selectedDistrict == null ||
                                          locationController.text.isEmpty ||
                                          messageController.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Please fill all fields'),
                                          ),
                                        );
                                        return;
                                      }

                                      setState(() {
                                        isLoading = true; // Show loader
                                      });

                                      try {
                                        // Insert data into Supabase
                                        await supabase.from('reports').insert({
                                          'district': selectedDistrict,
                                          'location': locationController.text,
                                          'message': messageController.text,
                                        });

                                        // Show success dialog
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Success'),
                                            content: const Text('Your report has been submitted.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context); // Close dialog
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );

                                        // Clear form fields
                                        setState(() {
                                          selectedDistrict = null;
                                          locationController.clear();
                                          messageController.clear();
                                        });
                                      } catch (e) {
                                        
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Error: $e'),
                                          ),
                                        );
                                      } finally {
                                        setState(() {
                                          isLoading = false; // Hide loader
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 40,
                                        vertical: 16,
                                      ),
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
                                      child: Center(
                                        child: Text(
                                          'Submit',
                                          style: CustomStyle.Medium.copyWith(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(height: 20), // Extra space at the bottom
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


