import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/models.dart';
import '../widgets/destination_card.dart';
import '../widgets/trip_card.dart';
import '../widgets/create_trip_sheet.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Destination> _filteredDestinations = List.from(dummyDestinations);
  late List<Trip> _communityTrips;

  @override
  void initState() {
    super.initState();
    _communityTrips = dummyTrips.where((t) => t.isPublic).toList();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _filteredDestinations = List.from(dummyDestinations);
      } else {
        _filteredDestinations = dummyDestinations.where((d) {
          return d.name.toLowerCase().contains(query) ||
              d.country.toLowerCase().contains(query) ||
              d.description.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _openCreateTripSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateTripSheet(
        onTripCreated: () {
          setState(() {
            _communityTrips.insert(
              0,
              Trip(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                destination: 'New Adventure',
                coverUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&q=80&w=800',
                startDate: DateTime.now().add(const Duration(days: 14)),
                endDate: DateTime.now().add(const Duration(days: 21)),
                budget: 1500.0,
                status: 'Planning',
                isPublic: true,
                isOwner: true,
                members: [dummyMembers[0]],
                chatMessages: [],
                activities: [],
                gallery: [],
              ),
            );
          });
        },
      ),
    );
  }

  void _showJoinSuccess(String destination) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Request sent successfully for $destination!'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Explore Trips',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Find destinations or create your next adventure.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Search Bar
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                hintText: 'Search destinations, cities or countries',
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchController.clear();
                              },
                            ),
                          IconButton(
                            icon: Icon(Icons.tune, color: Theme.of(context).colorScheme.primary),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Filter settings opened')),
                              );
                            },
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Quick Action Cards
                    Row(
                      children: [
                        _buildQuickActionCard(
                          context,
                          title: 'Create Trip',
                          icon: Icons.add_circle_outline,
                          color: Theme.of(context).colorScheme.primary,
                          onTap: _openCreateTripSheet,
                        ),
                        const SizedBox(width: 12),
                        _buildQuickActionCard(
                          context,
                          title: 'Join Trip',
                          icon: Icons.group_add_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Enter invite code or select a community trip below.')),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        _buildQuickActionCard(
                          context,
                          title: 'Discover',
                          icon: Icons.explore_outlined,
                          color: Colors.purple,
                          onTap: () {},
                        ),
                        const SizedBox(width: 12),
                        _buildQuickActionCard(
                          context,
                          title: 'Saved',
                          icon: Icons.bookmark_border,
                          color: Colors.amber[800]!,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    // Popular Destinations Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Destinations',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${_filteredDestinations.length} found',
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            // Horizontal Popular Destinations Carousel or Empty State
            if (_filteredDestinations.isNotEmpty)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 230,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filteredDestinations.length,
                    itemBuilder: (context, index) {
                      return DestinationCard(
                        destination: _filteredDestinations[index],
                      );
                    },
                  ),
                ),
              )
            else
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Column(
                    children: [
                      Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 12),
                      Text(
                        'No destinations match "${_searchController.text}"',
                        style: TextStyle(color: Colors.grey[600]),
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
                    const SizedBox(height: 12),
                    const Text(
                      'Popular Community Trips',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            // Community Trips List or Empty State
            if (_communityTrips.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final trip = _communityTrips[index];
                      return TripCard(
                        trip: trip,
                        onJoinPressed: () => _showJoinSuccess(trip.destination),
                        onTripLeft: () {
                          setState(() {
                            _communityTrips.removeAt(index);
                          });
                        },
                        onTripDeleted: () {
                          setState(() {
                            _communityTrips.removeAt(index);
                          });
                        },
                      );
                    },
                    childCount: _communityTrips.length,
                  ),
                ),
              )
            else
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.flight_land, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      const Text(
                        'No Trips Yet',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Start planning your next getaway today!',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _openCreateTripSheet,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('Create Trip'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
