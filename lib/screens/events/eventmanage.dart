import 'package:flutter/material.dart';

class ManageEventsSection extends StatefulWidget {
  const ManageEventsSection({super.key});

  @override
  _ManageEventsSectionState createState() => _ManageEventsSectionState();
}

class _ManageEventsSectionState extends State<ManageEventsSection> {
  // Dummy list of events
  final List<Map<String, dynamic>> _events = [
    {
      'id': '1',
      'name': 'Flutter Workshop',
      'description': 'Learn Flutter from scratch',
      'speaker': 'John Doe',
      'date': '2023-11-15',
      'mode': 'Online',
      'link': 'https://meet.google.com/abc-xyz',
      'isCompleted': false,
    },
    {
      'id': '2',
      'name': 'Tech Conference',
      'description': 'Annual tech conference',
      'speaker': 'Jane Smith',
      'date': '2023-12-01',
      'mode': 'Offline',
      'venue': 'Convention Center, New York',
      'isCompleted': false,
    },
    {
      'id': '3',
      'name': 'AI Seminar',
      'description': 'Introduction to Artificial Intelligence',
      'speaker': 'Alan Turing',
      'date': '2023-10-25',
      'mode': 'Online',
      'link': 'https://meet.google.com/def-uvw',
      'isCompleted': true,
    },
  ];

  // Filter for upcoming/completed events
  bool _showUpcoming = true;

  @override
  Widget build(BuildContext context) {
    // Filter events based on completion status
    final filteredEvents = _events.where((event) {
      return _showUpcoming ? !event['isCompleted'] : event['isCompleted'];
    }).toList();

    return Column(
      children: [
        // Toggle between upcoming and completed events
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: const Text('Upcoming'),
                selected: _showUpcoming,
                onSelected: (selected) {
                  setState(() {
                    _showUpcoming = true;
                  });
                },
              ),
              const SizedBox(width: 16),
              ChoiceChip(
                label: const Text('Completed'),
                selected: !_showUpcoming,
                onSelected: (selected) {
                  setState(() {
                    _showUpcoming = false;
                  });
                },
              ),
            ],
          ),
        ),

        // List of events
        Expanded(
          child: ListView.builder(
            itemCount: filteredEvents.length,
            itemBuilder: (context, index) {
              final event = filteredEvents[index];
              return EventCard(
                event: event,
                onMarkCompleted: () {
                  _markEventAsCompleted(event['id']);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // Function to mark an event as completed
  void _markEventAsCompleted(String eventId) {
    setState(() {
      final event = _events.firstWhere((e) => e['id'] == eventId);
      event['isCompleted'] = true;
    });
  }
}

// Custom widget to display event details
class EventCard extends StatelessWidget {
  final Map<String, dynamic> event;
  final VoidCallback onMarkCompleted;

  const EventCard({
    super.key,
    required this.event,
    required this.onMarkCompleted,
  });

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
              event['name'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(event['description']),
            const SizedBox(height: 8),
            Text('Speaker: ${event['speaker']}'),
            const SizedBox(height: 8),
            Text('Date: ${event['date']}'),
            const SizedBox(height: 8),
            Text(
              event['mode'] == 'Online'
                  ? 'Link: ${event['link']}'
                  : 'Venue: ${event['venue']}',
            ),
            const SizedBox(height: 16),
            if (!event['isCompleted'])
              ElevatedButton(
                onPressed: onMarkCompleted,
                child: const Text('Mark as Completed'),
              ),
          ],
        ),
      ),
    );
  }
}