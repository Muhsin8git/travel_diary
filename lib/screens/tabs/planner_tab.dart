import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../widgets/activity_card.dart';

class PlannerTab extends StatefulWidget {
  final Trip trip;

  const PlannerTab({super.key, required this.trip});

  @override
  State<PlannerTab> createState() => _PlannerTabState();
}

class _PlannerTabState extends State<PlannerTab> {
  late List<Activity> _activities;

  @override
  void initState() {
    super.initState();
    _activities = List.from(widget.trip.activities);
  }

  void _addActivity() {
    showDialog(
      context: context,
      builder: (context) {
        final titleController = TextEditingController();
        final locationController = TextEditingController();
        return AlertDialog(
          title: const Text('Add Activity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  setState(() {
                    _activities.add(
                      Activity(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: titleController.text,
                        location: locationController.text.isEmpty ? 'TBD' : locationController.text,
                        time: DateTime.now(),
                        iconName: 'map-pin',
                      ),
                    );
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_activities.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No activities planned yet',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _addActivity,
              icon: const Icon(Icons.add),
              label: const Text('Add Activity'),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: _activities.length,
          itemBuilder: (context, index) {
            return ActivityCard(activity: _activities[index]);
          },
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            heroTag: 'add_activity',
            onPressed: _addActivity,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
