import 'package:flutter/material.dart';

class FindResourceSection extends StatefulWidget {
  const FindResourceSection({super.key});

  @override
  _FindResourceSectionState createState() => _FindResourceSectionState();
}

class _FindResourceSectionState extends State<FindResourceSection> {
  // Dummy list of speakers
  final List<Map<String, dynamic>> _speakers = [
    {
      'id': '1',
      'name': 'John Doe',
      'designation': 'Flutter Developer',
      'contact': '+1234567890',
      'expertise': 'Mobile App Development',
    },
    {
      'id': '2',
      'name': 'Jane Smith',
      'designation': 'Data Scientist',
      'contact': '+0987654321',
      'expertise': 'Machine Learning',
    },
    {
      'id': '3',
      'name': 'Alan Turing',
      'designation': 'AI Researcher',
      'contact': '+1122334455',
      'expertise': 'Artificial Intelligence',
    },
    {
      'id': '4',
      'name': 'Grace Hopper',
      'designation': 'Software Engineer',
      'contact': '+5566778899',
      'expertise': 'Programming Languages',
    },
  ];

  // Search query
  String _searchQuery = '';

  // Filtered list of speakers based on search query
  List<Map<String, dynamic>> get _filteredSpeakers {
    if (_searchQuery.isEmpty) {
      return _speakers;
    }
    return _speakers.where((speaker) {
      return speaker['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
             speaker['designation'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
             speaker['expertise'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search Speakers',
              hintText: 'Enter name, designation, or expertise',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),

        // List of Speakers
        Expanded(
          child: ListView.builder(
            itemCount: _filteredSpeakers.length,
            itemBuilder: (context, index) {
              final speaker = _filteredSpeakers[index];
              return SpeakerCard(speaker: speaker);
            },
          ),
        ),
      ],
    );
  }
}

// Custom widget to display speaker details
class SpeakerCard extends StatelessWidget {
  final Map<String, dynamic> speaker;

  const SpeakerCard({super.key, required this.speaker});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              speaker['name'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Designation: ${speaker['designation']}'),
            const SizedBox(height: 8),
            Text('Expertise: ${speaker['expertise']}'),
            const SizedBox(height: 8),
            Text('Contact: ${speaker['contact']}'),
          ],
        ),
      ),
    );
  }
}