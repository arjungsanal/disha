import 'package:flutter/material.dart';

class CreateEventSection extends StatefulWidget {
  const CreateEventSection({super.key});

  @override
  _CreateEventSectionState createState() => _CreateEventSectionState();
}

class _CreateEventSectionState extends State<CreateEventSection> {
  final _formKey = GlobalKey<FormState>();
  final _eventNameController = TextEditingController();
  final _eventDescriptionController = TextEditingController();
  final _speakerNameController = TextEditingController();
  final _speakerContactController = TextEditingController();
  final _speakerDesignationController = TextEditingController();
  final _venueController = TextEditingController();
  final _gmeetLinkController = TextEditingController();

  String _eventMode = 'Offline'; // Default event mode

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            // Event Name
            TextFormField(
              controller: _eventNameController,
              decoration: const InputDecoration(
                labelText: 'Event Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an event name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Event Description
            TextFormField(
              controller: _eventDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Event Description',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an event description';
                }
                return null;
              },
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Speaker Name
            TextFormField(
              controller: _speakerNameController,
              decoration: const InputDecoration(
                labelText: 'Speaker Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a speaker name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Speaker Contact Number
            TextFormField(
              controller: _speakerContactController,
              decoration: const InputDecoration(
                labelText: 'Speaker Contact Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a contact number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Speaker Designation
            TextFormField(
              controller: _speakerDesignationController,
              decoration: const InputDecoration(
                labelText: 'Speaker Designation',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a designation';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Event Mode (Dropdown)
            DropdownButtonFormField<String>(
              value: _eventMode,
              decoration: const InputDecoration(
                labelText: 'Event Mode',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Offline',
                  child: Text('Offline'),
                ),
                DropdownMenuItem(
                  value: 'Online',
                  child: Text('Online'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _eventMode = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select an event mode';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Venue (Conditional for Offline)
            if (_eventMode == 'Offline')
              TextFormField(
                controller: _venueController,
                decoration: const InputDecoration(
                  labelText: 'Venue',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a venue';
                  }
                  return null;
                },
              ),

            // Google Meet Link (Conditional for Online)
            if (_eventMode == 'Online')
              TextFormField(
                controller: _gmeetLinkController,
                decoration: const InputDecoration(
                  labelText: 'Google Meet Link',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Google Meet link';
                  }
                  return null;
                },
              ),
            const SizedBox(height: 20),

            // Create Event Button
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Save event and speaker details
                  final eventName = _eventNameController.text;
                  final eventDescription = _eventDescriptionController.text;
                  final speakerName = _speakerNameController.text;
                  final speakerContact = _speakerContactController.text;
                  final speakerDesignation = _speakerDesignationController.text;
                  final venue = _venueController.text;
                  final gmeetLink = _gmeetLinkController.text;

                  // TODO: Save event and speaker to database
                  print('Event Created: $eventName');
                  print('Speaker: $speakerName');
                  print('Contact: $speakerContact');
                  print('Designation: $speakerDesignation');
                  print('Event Mode: $_eventMode');
                  if (_eventMode == 'Offline') {
                    print('Venue: $venue');
                  } else {
                    print('Google Meet Link: $gmeetLink');
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Create Event',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDescriptionController.dispose();
    _speakerNameController.dispose();
    _speakerContactController.dispose();
    _speakerDesignationController.dispose();
    _venueController.dispose();
    _gmeetLinkController.dispose();
    super.dispose();
  }
}