import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';
import '../screens/trip_details_screen.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback? onJoinPressed;
  final VoidCallback? onTripDeleted;
  final VoidCallback? onTripLeft;

  const TripCard({
    super.key,
    required this.trip,
    this.onJoinPressed,
    this.onTripDeleted,
    this.onTripLeft,
  });

  void _showMenuOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.share_outlined),
                  title: const Text('Share Trip'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Trip share link copied!')),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_add_outlined),
                  title: const Text('Invite Friends'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showInviteModal(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.link_outlined),
                  title: const Text('Copy Link'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Link copied to clipboard!')),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.orange),
                  title: const Text('Leave Trip', style: TextStyle(color: Colors.orange)),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _confirmLeaveTrip(context);
                  },
                ),
                if (trip.isOwner)
                  ListTile(
                    leading: const Icon(Icons.delete_outline, color: Colors.red),
                    title: const Text('Delete Trip', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      _confirmDeleteTrip(context);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showInviteModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Invite Members'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share Link'),
                onTap: () {
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invite link shared!')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.qr_code),
                title: const Text('QR Code'),
                onTap: () {
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Displaying QR code...')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.alternate_email),
                title: const Text('Username'),
                onTap: () {
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invited via Username!')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmLeaveTrip(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Leave Trip'),
          content: const Text('Are you sure you want to leave this trip?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                onTripLeft?.call();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('You left the trip.')),
                );
              },
              child: const Text('Leave', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteTrip(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Delete Trip'),
          content: const Text('Are you sure you want to delete this trip permanently?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                onTripDeleted?.call();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Trip deleted.')),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d');
    final dateRange = '${dateFormat.format(trip.startDate)} - ${dateFormat.format(trip.endDate)}';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripDetailsScreen(trip: trip),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Image.network(
                trip.coverUrl,
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: 240,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Row(
                  children: [
                    if (trip.isPublic)
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.public, color: Colors.white, size: 12),
                            SizedBox(width: 4),
                            Text(
                              'Public',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        trip.status,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () => _showMenuOptions(context),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.more_vert, color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trip.destination,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, color: Colors.white70, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                dateRange,
                                style: const TextStyle(color: Colors.white70, fontSize: 13),
                              ),
                              const SizedBox(width: 14),
                              const Icon(Icons.group, color: Colors.white70, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                '${trip.members.length}',
                                style: const TextStyle(color: Colors.white70, fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (onJoinPressed != null)
                      ElevatedButton(
                        onPressed: onJoinPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                        ),
                        child: const Text('Join', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
