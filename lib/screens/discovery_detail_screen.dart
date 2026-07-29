import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/models.dart';
import 'trip_details_screen.dart';

class DiscoveryDetailScreen extends StatefulWidget {
  final DiscoveryItem item;

  const DiscoveryDetailScreen({super.key, required this.item});

  @override
  State<DiscoveryDetailScreen> createState() => _DiscoveryDetailScreenState();
}

class _DiscoveryDetailScreenState extends State<DiscoveryDetailScreen> {
  bool _isSaved = false;

  void _handlePrimaryAction() {
    // Create new trip in dummyTrips
    final newTrip = Trip(
      id: 'joined_${DateTime.now().millisecondsSinceEpoch}',
      destination: widget.item.title,
      coverUrl: widget.item.imageUrl,
      startDate: DateTime.now().add(const Duration(days: 7)),
      endDate: DateTime.now().add(const Duration(days: 10)),
      budget: 1200.0,
      status: 'Upcoming',
      isPublic: true,
      isOwner: false, // Joined trip
      routeEndpoint: widget.item.location,
      isOpenForMembers: true,
      members: [dummyMembers[0], dummyMembers[1], dummyMembers[2]],
      chatMessages: [
        ChatMessage(
          id: 'c_joined_1',
          sender: dummyMembers[1],
          message: 'Welcome to ${widget.item.title}! Glad to have you in the squad 🎉',
          timestamp: DateTime.now(),
        ),
      ],
      activities: [
        Activity(
          id: 'a_joined_1',
          title: 'Assembly & Flag off',
          location: widget.item.location,
          time: DateTime.now().copyWith(hour: 7, minute: 0),
          iconName: 'flag',
        ),
      ],
      gallery: dummyPhotos.sublist(0, 6),
    );

    if (!dummyTrips.any((t) => t.destination == widget.item.title)) {
      dummyTrips.insert(0, newTrip);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎉 Joined ${widget.item.title}! Added to My Trips Hub.'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(
          label: 'View Trip',
          textColor: Colors.amber,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TripDetailsScreen(trip: newTrip)),
            );
          },
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 320,
                pinned: true,
                backgroundColor: Theme.of(context).colorScheme.primary,
                iconTheme: const IconThemeData(color: Colors.white),
                actions: [
                  IconButton(
                    icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_border, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _isSaved = !_isSaved;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(_isSaved ? 'Saved to bookmarks!' : 'Removed from bookmarks.')),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.white),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Link copied to clipboard!')),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    item.type.name.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    item.audienceType,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Quick Summary Info Chips
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 4),
                          Text(item.location, style: const TextStyle(fontWeight: FontWeight.w600)),
                          const Spacer(),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(item.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildInfoCol('WHEN', item.dateStr),
                            Container(width: 1, height: 30, color: Colors.grey.withOpacity(0.3)),
                            _buildInfoCol('PRICE / BUDGET', item.priceOrBudget),
                            Container(width: 1, height: 30, color: Colors.grey.withOpacity(0.3)),
                            _buildInfoCol('ATTENDING', '${item.attendeesCount} people'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Organizer Card
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(item.organizerAvatar),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.organizerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text('Host / Organizer', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text('About Experience', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(
                        item.description,
                        style: TextStyle(color: Colors.grey[700], height: 1.5, fontSize: 14),
                      ),
                      const SizedBox(height: 24),
                      // Tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: item.tags.map((t) {
                          return Chip(
                            label: Text('#$t', style: const TextStyle(fontSize: 12)),
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
                            side: BorderSide.none,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 100), // Space for bottom bar
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Fixed Bottom Action Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price / Share', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                        Text(
                          item.priceOrBudget,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _handlePrimaryAction,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        child: Text(
                          _getButtonText(item.type),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getButtonText(DiscoveryType type) {
    switch (type) {
      case DiscoveryType.event:
      case DiscoveryType.camping:
        return 'Join Event 🎉';
      case DiscoveryType.communityTrip:
      case DiscoveryType.bikerClub:
      case DiscoveryType.offRoading:
        return 'Join Group 🎒';
      case DiscoveryType.destination:
      case DiscoveryType.hiking:
      case DiscoveryType.roadTrip:
        return 'Plan Trip 🗺️';
      default:
        return 'Book Experience ✨';
    }
  }

  Widget _buildInfoCol(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
