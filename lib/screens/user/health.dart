import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  // Dummy health metrics for deaddiction journey
  final Map<String, String> _healthMetrics = {
    'Days Sober': '45',
    'Cravings Resisted': '23',
    'Mood Level': '7/10',
  };

  // List of relevant health tips for deaddiction
  final Map<int, String> _moodTips = {
    1: 'It’s okay to have tough days. Reach out to a friend or support group.',
    2: 'Take a deep breath. You’re stronger than you think.',
    3: 'Try a short walk or some light exercise to lift your spirits.',
    4: 'Write down your thoughts. Journaling can help you process emotions.',
    5: 'Focus on small wins today. Every step counts.',
    6: 'Listen to calming music or practice mindfulness.',
    7: 'You’re doing great! Keep focusing on your progress.',
    8: 'Celebrate how far you’ve come. You’re inspiring!',
    9: 'Share your positivity with someone else today.',
    10: 'You’re thriving! Keep up the amazing work.',
  };

  // Current mood level
  int _currentMoodLevel = 7;

  // Current random tip
  String _currentTip = '';

  // List of medicines
  final List<String> _medicines = [];

  // List of medical documents (dummy data for now)
  final List<String> _medicalDocuments = [];

  @override
  void initState() {
    super.initState();
    _generateRandomTip(); // Generate the initial tip when the screen loads
  }

  // Generate a random health tip based on the current mood level
  void _generateRandomTip() {
    setState(() {
      _currentTip = _moodTips[_currentMoodLevel] ?? 'Stay strong and keep going!';
    });
  }

  // Show a dialog to edit mood level
  void _editMoodLevel(BuildContext context) {
    // Local variable to manage the slider value temporarily
    int tempMoodLevel = _currentMoodLevel;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Mood Level'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('How are you feeling today?'),
              const SizedBox(height: 16),
              Slider(
                value: tempMoodLevel.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                label: tempMoodLevel.toString(),
                onChanged: (double value) {
                  // Update the local variable when the slider is dragged
                  setState(() {
                    tempMoodLevel = value.toInt();
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Update the main state variable and regenerate the tip
                setState(() {
                  _currentMoodLevel = tempMoodLevel;
                  _generateRandomTip(); // Regenerate the tip when mood level changes
                });
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Show SOS dialog for low mood levels
  void _showSOSDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Need Help?'),
          content: const Text(
              'You’re not alone. Reach out for support now.'),
          actions: [
            TextButton(
              onPressed: () async {
                // Call a helpline
                Navigator.of(context).pop();
                await _callHelpline();
              },
              child: const Text('Call Helpline'),
            ),
            TextButton(
              onPressed: () async {
                // Send a message to a trusted contact
                Navigator.of(context).pop();
                await _messageFriend();
              },
              child: const Text('Message a Friend'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Call a helpline
  Future<void> _callHelpline() async {
    const String helplineNumber = 'tel:+1234567890'; // Replace with a real helpline number
    if (await canLaunch(helplineNumber)) {
      await launch(helplineNumber);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch the phone app.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Send a message to a trusted contact
  Future<void> _messageFriend() async {
    const String message = 'I need your support right now.'; // Customize the message
    const String phoneNumber = 'sms:+1234567890'; // Replace with a real phone number
    if (await canLaunch('$phoneNumber?body=$message')) {
      await launch('$phoneNumber?body=$message');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch the messaging app.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Show a dialog to add a new medicine
  void _addMedicineDialog(BuildContext context) {
    TextEditingController medicineController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Medicine'),
          content: TextField(
            controller: medicineController,
            decoration: const InputDecoration(
              hintText: 'Enter medicine name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (medicineController.text.isNotEmpty) {
                  setState(() {
                    _medicines.add(medicineController.text);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Show a dialog to view medical documents
  void _viewMedicalDocumentsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Medical Documents'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _medicalDocuments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_medicalDocuments[index]),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  'Deaddiction Journey',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                // Health Metrics
                Row(
                  children: _healthMetrics.entries.map((entry) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: entry.key == 'Mood Level' ? () => _editMoodLevel(context) : null,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.grey[100],
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  entry.key == 'Mood Level' ? '$_currentMoodLevel/10' : entry.value,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                // SOS Button (Visible only if mood level is less than 3)
                if (_currentMoodLevel < 3)
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.red[100],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'You seem to be feeling low. Reach out for help.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => _showSOSDialog(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              'SOS - Get Help Now',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                // Personalized Health Tip
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Your Personalized Tip',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: _generateRandomTip, // Refresh the tip
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _currentTip, // Display the current tip
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Medicines and Medical Documents Section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Medicines & Documents',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Add Medicine Button
                        ElevatedButton(
                          onPressed: () => _addMedicineDialog(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Add Medicine',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // View Medicines List
                        if (_medicines.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Your Medicines:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ..._medicines.map((medicine) {
                                return ListTile(
                                  title: Text(medicine),
                                );
                              }).toList(),
                            ],
                          ),
                        const SizedBox(height: 16),
                        // View Medical Documents Button
                        ElevatedButton(
                          onPressed: () => _viewMedicalDocumentsDialog(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'View Medical Documents',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}