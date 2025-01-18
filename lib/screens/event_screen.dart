import 'package:disha/screens/events/eventcreation.dart';
import 'package:disha/screens/events/eventmanage.dart';
import 'package:disha/screens/events/eventresource.dart';
import 'package:flutter/material.dart';

class EventSection extends StatelessWidget {
  const EventSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Event Section',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 1, // Subtle shadow
          bottom: TabBar(
            indicatorColor: Colors.deepPurple, // Indicator color
            labelColor: Colors.deepPurple, // Selected tab text color
            unselectedLabelColor: Colors.black54, // Unselected tab text color
            tabs: const [
              Tab(
                icon: Icon(Icons.add_circle_outline, size: 20),
                text: 'Create Event',
              ),
              Tab(
                icon: Icon(Icons.calendar_today_outlined, size: 20),
                text: 'Manage Events',
              ),
              Tab(
                icon: Icon(Icons.person_search_outlined, size: 20),
                text: 'Find Resource',
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.grey[50], // Light background color
          child: const TabBarView(
            children: [
              // Content for Create Event tab
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: CreateEventSection(),
                ),
              ),

              // Content for Manage Events tab
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: ManageEventsSection(),
                ),
              ),

              // Content for Find Resource tab
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: FindResourceSection(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}